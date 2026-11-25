
vector_lane_runs_keep_what_they_do_not_write.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x208, %rsp            # imm = 0x208
               	xorl	%eax, %eax
               	leaq	(%rsp), %rcx
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	addq	%rdx, %rcx
               	movq	$-0x1, (%rcx)
               	incq	%rax
               	cmpl	$0x40, %eax
               	jl	<addr>
               	addq	$0x208, %rsp            # imm = 0x208
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
               	subq	$0x58, %rsp
               	movl	$0x7, 0x48(%rsp)
               	leaq	(%rsp), %r9
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movl	0x48(%rsp), %edi
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
               	addq	$0x58, %rsp
               	retq
               	movl	$0x0, 0x18(%rsp)
               	leaq	(%rsp), %r9
               	movl	0x48(%rsp), %edi
               	leaq	0x18(%rsp), %rsi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movl	0x18(%rsp), %eax
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
               	addq	$0x58, %rsp
               	retq
               	movl	0x48(%rsp), %edi
               	movl	0x48(%rsp), %eax
               	leaq	0x1(%rax), %rsi
               	movl	0x48(%rsp), %eax
               	leaq	0x2(%rax), %rdx
               	movl	0x48(%rsp), %eax
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
               	addq	$0x58, %rsp
               	retq
               	xorl	%eax, %eax
               	imulq	$0xd, %rax, %rcx
               	movl	0x48(%rsp), %esi
               	addq	%rsi, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, 0x28(%rsp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x28(%rsp), %rdi
               	callq	<addr>
               	vpextrb	$0x0, %xmm0, %eax
               	movzbq	0x28(%rsp), %rcx
               	cmpq	%rcx, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x58, %rsp
               	retq
               	vpextrb	$0x1, %xmm0, %eax
               	movzbq	0x29(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x2, %xmm0, %eax
               	movzbq	0x2a(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x3, %xmm0, %eax
               	movzbq	0x2b(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x4, %xmm0, %eax
               	movzbq	0x2c(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x5, %xmm0, %eax
               	movzbq	0x2d(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x6, %xmm0, %eax
               	movzbq	0x2e(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x7, %xmm0, %eax
               	movzbq	0x2f(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x8, %xmm0, %eax
               	movzbq	0x30(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0x9, %xmm0, %eax
               	movzbq	0x31(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xa, %xmm0, %eax
               	movzbq	0x32(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xb, %xmm0, %eax
               	movzbq	0x33(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xc, %xmm0, %eax
               	movzbq	0x34(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xd, %xmm0, %eax
               	movzbq	0x35(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xe, %xmm0, %eax
               	movzbq	0x36(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	vpextrb	$0xf, %xmm0, %eax
               	movzbq	0x37(%rsp), %rcx
               	cmpq	%rcx, %rax
               	jne	<addr>
               	leaq	0x20(%rsp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movl	0x48(%rsp), %esi
               	movl	0x48(%rsp), %eax
               	movq	%rax, %rdx
               	negq	%rdx
               	callq	<addr>
               	movl	0x20(%rsp), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movl	0x24(%rsp), %eax
               	cmpl	$-0x7, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x58, %rsp
               	retq
               	leaq	0x38(%rsp), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rdi)
               	movl	0x8(%rax), %r10d
               	movl	%r10d, 0x8(%rdi)
               	movl	0x48(%rsp), %esi
               	callq	<addr>
               	movl	0x38(%rsp), %eax
               	cmpl	$0x7, %eax
               	jne	<addr>
               	cmpl	$0x0, 0x3c(%rsp)
               	jne	<addr>
               	cmpl	$0x0, 0x40(%rsp)
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x58, %rsp
               	retq
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x58, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x58, %rsp
               	retq
