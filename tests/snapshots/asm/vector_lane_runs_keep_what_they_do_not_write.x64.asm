
vector_lane_runs_keep_what_they_do_not_write.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<partial>:
               	vpinsrd	$0x1, %edi, %xmm0, %xmm0
               	vpinsrd	$0x3, %edi, %xmm0, %xmm0
               	retq

<read_between>:
               	vpextrd	$0x2, %xmm0, %eax
               	movslq	%eax, %rax
               	movl	%eax, (%rsi)
               	vmovd	%edi, %xmm0
               	vpbroadcastd	%xmm0, %xmm0
               	retq

<full>:
               	vmovd	%edi, %xmm0
               	vpinsrd	$0x1, %esi, %xmm0, %xmm0
               	vpinsrd	$0x2, %edx, %xmm0, %xmm0
               	vpinsrd	$0x3, %ecx, %xmm0, %xmm0
               	retq

<bytes>:
               	movzbq	(%rdi), %rax
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	movzbq	0x1(%rdi), %rax
               	vpinsrb	$0x1, %eax, %xmm0, %xmm0
               	movzbq	0x2(%rdi), %rax
               	vpinsrb	$0x2, %eax, %xmm0, %xmm0
               	movzbq	0x3(%rdi), %rax
               	vpinsrb	$0x3, %eax, %xmm0, %xmm0
               	movzbq	0x4(%rdi), %rax
               	vpinsrb	$0x4, %eax, %xmm0, %xmm0
               	movzbq	0x5(%rdi), %rax
               	vpinsrb	$0x5, %eax, %xmm0, %xmm0
               	movzbq	0x6(%rdi), %rax
               	vpinsrb	$0x6, %eax, %xmm0, %xmm0
               	movzbq	0x7(%rdi), %rax
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	movzbq	0x8(%rdi), %rax
               	vpinsrb	$0x8, %eax, %xmm0, %xmm0
               	movzbq	0x9(%rdi), %rax
               	vpinsrb	$0x9, %eax, %xmm0, %xmm0
               	movzbq	0xa(%rdi), %rax
               	vpinsrb	$0xa, %eax, %xmm0, %xmm0
               	movzbq	0xb(%rdi), %rax
               	vpinsrb	$0xb, %eax, %xmm0, %xmm0
               	movzbq	0xc(%rdi), %rax
               	vpinsrb	$0xc, %eax, %xmm0, %xmm0
               	movzbq	0xd(%rdi), %rax
               	vpinsrb	$0xd, %eax, %xmm0, %xmm0
               	movzbq	0xe(%rdi), %rax
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	movzbq	0xf(%rdi), %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	retq

<dirty>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x200, %rsp            # imm = 0x200
               	xorl	%eax, %eax
               	leaq	-0x200(%rbp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	movq	$-0x1, (%rcx)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	leave
               	retq

<pointer_member>:
               	xorl	%eax, %eax
               	retq

<put2>:
               	movl	%esi, (%rdi)
               	movl	%edx, 0x4(%rdi)
               	retq

<put3>:
               	movl	%esi, %ecx
               	movq	%rcx, (%rdi)
               	movl	$0x0, 0x8(%rdi)
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movl	$0x7, -0x8(%rbp)
               	leaq	-0x50(%rbp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movl	-0x8(%rbp), %edi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0xa, %rax
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x1e, %rax
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movl	$0x0, -0x38(%rbp)
               	leaq	-0x50(%rbp), %r9
               	movl	-0x8(%rbp), %edi
               	leaq	-0x38(%rbp), %rsi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movl	-0x38(%rbp), %eax
               	cmpl	$0x1e, %eax
               	jne	<addr>
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movl	-0x8(%rbp), %edi
               	movl	-0x8(%rbp), %eax
               	leaq	0x1(%rax), %rsi
               	movl	-0x8(%rbp), %eax
               	leaq	0x2(%rax), %rdx
               	movl	-0x8(%rbp), %eax
               	leaq	0x3(%rax), %rcx
               	callq	<addr>
               	vmovd	%xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	vpextrd	$0x1, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	vpextrd	$0x2, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	vpextrd	$0x3, %xmm0, %eax
               	movslq	%eax, %rax
               	cmpq	$0xa, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	imulq	$0xd, %rax, %rdx
               	movl	-0x8(%rbp), %esi
               	addq	%rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x28(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x28(%rbp), %rdi
               	callq	<addr>
               	vpextrb	$0x0, %xmm0, %eax
               	movzbq	-0x28(%rbp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	vpextrb	$0x1, %xmm0, %eax
               	movzbq	-0x27(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x2, %xmm0, %eax
               	movzbq	-0x26(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x3, %xmm0, %eax
               	movzbq	-0x25(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x4, %xmm0, %eax
               	movzbq	-0x24(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x5, %xmm0, %eax
               	movzbq	-0x23(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x6, %xmm0, %eax
               	movzbq	-0x22(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x7, %xmm0, %eax
               	movzbq	-0x21(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x8, %xmm0, %eax
               	movzbq	-0x20(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x9, %xmm0, %eax
               	movzbq	-0x1f(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xa, %xmm0, %eax
               	movzbq	-0x1e(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xb, %xmm0, %eax
               	movzbq	-0x1d(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xc, %xmm0, %eax
               	movzbq	-0x1c(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xd, %xmm0, %eax
               	movzbq	-0x1b(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xe, %xmm0, %eax
               	movzbq	-0x1a(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xf, %xmm0, %eax
               	movzbq	-0x19(%rbp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	-0x30(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movl	-0x8(%rbp), %esi
               	movl	-0x8(%rbp), %eax
               	movq	%rax, %rdx
               	negq	%rdx
               	callq	<addr>
               	movl	-0x30(%rbp), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	-0x2c(%rbp), %eax
               	cmpl	$-0x7, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	-0x18(%rbp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rdi)
               	movl	-0x8(%rbp), %esi
               	callq	<addr>
               	movl	-0x18(%rbp), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	cmpl	$0x0, -0x14(%rbp)
               	jne	<addr>
               	cmpl	$0x0, -0x10(%rbp)
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
