
gcc_vector_state_array_update.x64:	file format elf64-x86-64

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

<mix>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	vpextrb	$0x0, %xmm0, %eax
               	shlq	%rax
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm1
               	vpinsrb	$0x0, %eax, %xmm1, %xmm1
               	vpextrb	$0x1, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0x1, %eax, %xmm1, %xmm1
               	vpextrb	$0x2, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0x2, %eax, %xmm1, %xmm1
               	vpextrb	$0x3, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0x3, %eax, %xmm1, %xmm1
               	vpextrb	$0x4, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0x4, %eax, %xmm1, %xmm1
               	vpextrb	$0x5, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0x5, %eax, %xmm1, %xmm1
               	vpextrb	$0x6, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0x6, %eax, %xmm1, %xmm1
               	vpextrb	$0x7, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0x7, %eax, %xmm1, %xmm1
               	vpextrb	$0x8, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0x8, %eax, %xmm1, %xmm1
               	vpextrb	$0x9, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0x9, %eax, %xmm1, %xmm1
               	vpextrb	$0xa, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0xa, %eax, %xmm1, %xmm1
               	vpextrb	$0xb, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0xb, %eax, %xmm1, %xmm1
               	vpextrb	$0xc, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0xc, %eax, %xmm1, %xmm1
               	vpextrb	$0xd, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0xd, %eax, %xmm1, %xmm1
               	vpextrb	$0xe, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0xe, %eax, %xmm1, %xmm1
               	vpextrb	$0xf, %xmm0, %eax
               	shlq	%rax
               	vpinsrb	$0xf, %eax, %xmm1, %xmm1
               	vpextrb	$0x0, %xmm0, %eax
               	movq	%rax, %rcx
               	shrq	$0x7, %rcx
               	vpextrb	$0x1, %xmm0, %eax
               	movq	%rax, %rdx
               	shrq	$0x7, %rdx
               	vpextrb	$0x2, %xmm0, %eax
               	movq	%rax, %rsi
               	shrq	$0x7, %rsi
               	vpextrb	$0x3, %xmm0, %eax
               	movq	%rax, %rdi
               	shrq	$0x7, %rdi
               	vpextrb	$0x4, %xmm0, %eax
               	movq	%rax, %r8
               	shrq	$0x7, %r8
               	vpextrb	$0x5, %xmm0, %eax
               	movq	%rax, %r9
               	shrq	$0x7, %r9
               	vpextrb	$0x6, %xmm0, %eax
               	movq	%rax, %rbx
               	shrq	$0x7, %rbx
               	vpextrb	$0x7, %xmm0, %eax
               	movq	%rax, %r12
               	shrq	$0x7, %r12
               	vpextrb	$0x8, %xmm0, %eax
               	movq	%rax, %r13
               	shrq	$0x7, %r13
               	vpextrb	$0x9, %xmm0, %eax
               	movq	%rax, %r14
               	shrq	$0x7, %r14
               	vpextrb	$0xa, %xmm0, %eax
               	movq	%rax, %r15
               	shrq	$0x7, %r15
               	vpextrb	$0xb, %xmm0, %eax
               	movq	%rax, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x58(%rsp)
               	vpextrb	$0xc, %xmm0, %eax
               	movq	%rax, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x50(%rsp)
               	vpextrb	$0xd, %xmm0, %eax
               	movq	%rax, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x48(%rsp)
               	vpextrb	$0xe, %xmm0, %eax
               	movq	%rax, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x40(%rsp)
               	vpextrb	$0xf, %xmm0, %eax
               	movq	%rax, %r10
               	shrq	$0x7, %r10
               	movq	%r10, 0x38(%rsp)
               	movl	$0x1b, %eax
               	andq	$0xff, %rcx
               	imulq	%rax, %rcx
               	xorl	%r10d, %r10d
               	movq	%r10, 0x30(%rsp)
               	movups	0x28(%rsp), %xmm0
               	vpinsrb	$0x0, %ecx, %xmm0, %xmm0
               	andq	$0xff, %rdx
               	imulq	%rax, %rdx
               	vpinsrb	$0x1, %edx, %xmm0, %xmm0
               	andq	$0xff, %rsi
               	imulq	%rax, %rsi
               	vpinsrb	$0x2, %esi, %xmm0, %xmm0
               	andq	$0xff, %rdi
               	imulq	%rax, %rdi
               	vpinsrb	$0x3, %edi, %xmm0, %xmm0
               	andq	$0xff, %r8
               	imulq	%rax, %r8
               	vpinsrb	$0x4, %r8d, %xmm0, %xmm0
               	andq	$0xff, %r9
               	imulq	%rax, %r9
               	vpinsrb	$0x5, %r9d, %xmm0, %xmm0
               	andq	$0xff, %rbx
               	imulq	%rax, %rbx
               	vpinsrb	$0x6, %ebx, %xmm0, %xmm0
               	andq	$0xff, %r12
               	imulq	%rax, %r12
               	vpinsrb	$0x7, %r12d, %xmm0, %xmm0
               	andq	$0xff, %r13
               	imulq	%rax, %r13
               	vpinsrb	$0x8, %r13d, %xmm0, %xmm0
               	andq	$0xff, %r14
               	imulq	%rax, %r14
               	vpinsrb	$0x9, %r14d, %xmm0, %xmm0
               	andq	$0xff, %r15
               	imulq	%rax, %r15
               	vpinsrb	$0xa, %r15d, %xmm0, %xmm0
               	movq	0x58(%rsp), %rcx
               	andq	$0xff, %rcx
               	imulq	%rax, %rcx
               	vpinsrb	$0xb, %ecx, %xmm0, %xmm0
               	movq	0x50(%rsp), %rcx
               	andq	$0xff, %rcx
               	imulq	%rax, %rcx
               	vpinsrb	$0xc, %ecx, %xmm0, %xmm0
               	movq	0x48(%rsp), %rcx
               	andq	$0xff, %rcx
               	imulq	%rax, %rcx
               	vpinsrb	$0xd, %ecx, %xmm0, %xmm0
               	movq	0x40(%rsp), %rcx
               	andq	$0xff, %rcx
               	imulq	%rax, %rcx
               	vpinsrb	$0xe, %ecx, %xmm0, %xmm0
               	movq	0x38(%rsp), %rcx
               	andq	$0xff, %rcx
               	imulq	%rcx, %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	pxor	%xmm1, %xmm0
               	movl	$0x63, %eax
               	vpextrb	$0x0, %xmm0, %ecx
               	xorq	%rax, %rcx
               	xorl	%edx, %edx
               	movq	%rdx, %xmm1
               	vpinsrb	$0x0, %ecx, %xmm1, %xmm1
               	vpextrb	$0x1, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0x1, %ecx, %xmm1, %xmm1
               	vpextrb	$0x2, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0x2, %ecx, %xmm1, %xmm1
               	vpextrb	$0x3, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0x3, %ecx, %xmm1, %xmm1
               	vpextrb	$0x4, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0x4, %ecx, %xmm1, %xmm1
               	vpextrb	$0x5, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0x5, %ecx, %xmm1, %xmm1
               	vpextrb	$0x6, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0x6, %ecx, %xmm1, %xmm1
               	vpextrb	$0x7, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0x7, %ecx, %xmm1, %xmm1
               	vpextrb	$0x8, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0x8, %ecx, %xmm1, %xmm1
               	vpextrb	$0x9, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0x9, %ecx, %xmm1, %xmm1
               	vpextrb	$0xa, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0xa, %ecx, %xmm1, %xmm1
               	vpextrb	$0xb, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0xb, %ecx, %xmm1, %xmm1
               	vpextrb	$0xc, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0xc, %ecx, %xmm1, %xmm1
               	vpextrb	$0xd, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0xd, %ecx, %xmm1, %xmm1
               	vpextrb	$0xe, %xmm0, %ecx
               	xorq	%rax, %rcx
               	vpinsrb	$0xe, %ecx, %xmm1, %xmm1
               	vpextrb	$0xf, %xmm0, %ecx
               	xorq	%rcx, %rax
               	movapd	%xmm1, %xmm0
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<save_state>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x60(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x58(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x40(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x38(%rbp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, -0x30(%rbp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, -0x28(%rbp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, -0x20(%rbp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, -0x18(%rbp)
               	leaq	-0x60(%rbp), %rax
               	leaq	-0x10(%rbp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movzbq	-0x10(%rbp), %rax
               	movb	%al, (%rdi)
               	movzbq	-0xf(%rbp), %rax
               	movb	%al, 0x1(%rdi)
               	movzbq	-0xe(%rbp), %rax
               	movb	%al, 0x2(%rdi)
               	movzbq	-0xd(%rbp), %rax
               	movb	%al, 0x3(%rdi)
               	movzbq	-0xc(%rbp), %rax
               	movb	%al, 0x4(%rdi)
               	movzbq	-0xb(%rbp), %rax
               	movb	%al, 0x5(%rdi)
               	movzbq	-0xa(%rbp), %rax
               	movb	%al, 0x6(%rdi)
               	movzbq	-0x9(%rbp), %rax
               	movb	%al, 0x7(%rdi)
               	movzbq	-0x8(%rbp), %rax
               	movb	%al, 0x8(%rdi)
               	movzbq	-0x7(%rbp), %rax
               	movb	%al, 0x9(%rdi)
               	movzbq	-0x6(%rbp), %rax
               	movb	%al, 0xa(%rdi)
               	movzbq	-0x5(%rbp), %rax
               	movb	%al, 0xb(%rdi)
               	leaq	-0x10(%rbp), %rcx
               	movzbq	-0x4(%rbp), %rax
               	movb	%al, 0xc(%rdi)
               	movzbq	-0x3(%rbp), %rax
               	movb	%al, 0xd(%rdi)
               	movzbq	-0x2(%rbp), %rax
               	movb	%al, 0xe(%rdi)
               	movzbq	-0x1(%rbp), %rax
               	movb	%al, 0xf(%rdi)
               	leaq	0x10(%rdi), %rax
               	leaq	-0x60(%rbp), %rdx
               	addq	$0x10, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movzbq	-0x10(%rbp), %rcx
               	movb	%cl, (%rax)
               	movzbq	-0xf(%rbp), %rcx
               	movb	%cl, 0x1(%rax)
               	movzbq	-0xe(%rbp), %rcx
               	movb	%cl, 0x2(%rax)
               	movzbq	-0xd(%rbp), %rcx
               	movb	%cl, 0x3(%rax)
               	movzbq	-0xc(%rbp), %rcx
               	movb	%cl, 0x4(%rax)
               	movzbq	-0xb(%rbp), %rcx
               	movb	%cl, 0x5(%rax)
               	movzbq	-0xa(%rbp), %rcx
               	movb	%cl, 0x6(%rax)
               	movzbq	-0x9(%rbp), %rcx
               	movb	%cl, 0x7(%rax)
               	movzbq	-0x8(%rbp), %rcx
               	movb	%cl, 0x8(%rax)
               	movzbq	-0x7(%rbp), %rcx
               	movb	%cl, 0x9(%rax)
               	movzbq	-0x6(%rbp), %rcx
               	movb	%cl, 0xa(%rax)
               	movzbq	-0x5(%rbp), %rcx
               	movb	%cl, 0xb(%rax)
               	movzbq	-0x4(%rbp), %rcx
               	movb	%cl, 0xc(%rax)
               	movzbq	-0x3(%rbp), %rcx
               	movb	%cl, 0xd(%rax)
               	leaq	-0x10(%rbp), %rcx
               	movzbq	-0x2(%rbp), %rdx
               	movb	%dl, 0xe(%rax)
               	movzbq	-0x1(%rbp), %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	0x20(%rdi), %rax
               	leaq	-0x60(%rbp), %rdx
               	addq	$0x20, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movzbq	-0x10(%rbp), %rcx
               	movb	%cl, (%rax)
               	movzbq	-0xf(%rbp), %rcx
               	movb	%cl, 0x1(%rax)
               	movzbq	-0xe(%rbp), %rcx
               	movb	%cl, 0x2(%rax)
               	movzbq	-0xd(%rbp), %rcx
               	movb	%cl, 0x3(%rax)
               	movzbq	-0xc(%rbp), %rcx
               	movb	%cl, 0x4(%rax)
               	movzbq	-0xb(%rbp), %rcx
               	movb	%cl, 0x5(%rax)
               	movzbq	-0xa(%rbp), %rcx
               	movb	%cl, 0x6(%rax)
               	movzbq	-0x9(%rbp), %rcx
               	movb	%cl, 0x7(%rax)
               	movzbq	-0x8(%rbp), %rcx
               	movb	%cl, 0x8(%rax)
               	movzbq	-0x7(%rbp), %rcx
               	movb	%cl, 0x9(%rax)
               	movzbq	-0x6(%rbp), %rcx
               	movb	%cl, 0xa(%rax)
               	movzbq	-0x5(%rbp), %rcx
               	movb	%cl, 0xb(%rax)
               	movzbq	-0x4(%rbp), %rcx
               	movb	%cl, 0xc(%rax)
               	movzbq	-0x3(%rbp), %rcx
               	movb	%cl, 0xd(%rax)
               	movzbq	-0x2(%rbp), %rcx
               	movb	%cl, 0xe(%rax)
               	leaq	-0x10(%rbp), %rcx
               	movzbq	-0x1(%rbp), %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	0x30(%rdi), %rax
               	leaq	-0x60(%rbp), %rdx
               	addq	$0x30, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movzbq	-0x10(%rbp), %rcx
               	movb	%cl, (%rax)
               	movzbq	-0xf(%rbp), %rcx
               	movb	%cl, 0x1(%rax)
               	movzbq	-0xe(%rbp), %rcx
               	movb	%cl, 0x2(%rax)
               	movzbq	-0xd(%rbp), %rcx
               	movb	%cl, 0x3(%rax)
               	movzbq	-0xc(%rbp), %rcx
               	movb	%cl, 0x4(%rax)
               	movzbq	-0xb(%rbp), %rcx
               	movb	%cl, 0x5(%rax)
               	movzbq	-0xa(%rbp), %rcx
               	movb	%cl, 0x6(%rax)
               	movzbq	-0x9(%rbp), %rcx
               	movb	%cl, 0x7(%rax)
               	movzbq	-0x8(%rbp), %rcx
               	movb	%cl, 0x8(%rax)
               	movzbq	-0x7(%rbp), %rcx
               	movb	%cl, 0x9(%rax)
               	movzbq	-0x6(%rbp), %rcx
               	movb	%cl, 0xa(%rax)
               	movzbq	-0x5(%rbp), %rcx
               	movb	%cl, 0xb(%rax)
               	movzbq	-0x4(%rbp), %rcx
               	movb	%cl, 0xc(%rax)
               	movzbq	-0x3(%rbp), %rcx
               	movb	%cl, 0xd(%rax)
               	movzbq	-0x2(%rbp), %rcx
               	movb	%cl, 0xe(%rax)
               	leaq	-0x10(%rbp), %rcx
               	movzbq	-0x1(%rbp), %rdx
               	movb	%dl, 0xf(%rax)
               	leaq	0x40(%rdi), %rax
               	leaq	-0x60(%rbp), %rdx
               	addq	$0x40, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rcx)
               	movzbq	-0x10(%rbp), %rcx
               	movb	%cl, (%rax)
               	movzbq	-0xf(%rbp), %rcx
               	movb	%cl, 0x1(%rax)
               	movzbq	-0xe(%rbp), %rcx
               	movb	%cl, 0x2(%rax)
               	movzbq	-0xd(%rbp), %rcx
               	movb	%cl, 0x3(%rax)
               	movzbq	-0xc(%rbp), %rcx
               	movb	%cl, 0x4(%rax)
               	movzbq	-0xb(%rbp), %rcx
               	movb	%cl, 0x5(%rax)
               	movzbq	-0xa(%rbp), %rcx
               	movb	%cl, 0x6(%rax)
               	movzbq	-0x9(%rbp), %rcx
               	movb	%cl, 0x7(%rax)
               	movzbq	-0x8(%rbp), %rcx
               	movb	%cl, 0x8(%rax)
               	movzbq	-0x7(%rbp), %rcx
               	movb	%cl, 0x9(%rax)
               	movzbq	-0x6(%rbp), %rcx
               	movb	%cl, 0xa(%rax)
               	movzbq	-0x5(%rbp), %rcx
               	movb	%cl, 0xb(%rax)
               	movzbq	-0x4(%rbp), %rcx
               	movb	%cl, 0xc(%rax)
               	movzbq	-0x3(%rbp), %rcx
               	movb	%cl, 0xd(%rax)
               	movzbq	-0x2(%rbp), %rcx
               	movb	%cl, 0xe(%rax)
               	movzbq	-0x1(%rbp), %rcx
               	movb	%cl, 0xf(%rax)
               	leave
               	retq

<update>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, -0x80(%rbp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, -0x78(%rbp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, -0x70(%rbp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, -0x68(%rbp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, -0x60(%rbp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, -0x58(%rbp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0x50(%rbp), %r10
               	movq	%r10, -0x40(%rbp)
               	movq	0x58(%rbp), %r10
               	movq	%r10, -0x38(%rbp)
               	movups	%xmm0, 0x50(%rsp)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x40(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	0x50(%rsp), %xmm15
               	pxor	%xmm0, %xmm15
               	movups	%xmm15, 0x50(%rsp)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x30(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	-0x40(%rbp), %xmm1
               	pxor	%xmm1, %xmm0
               	movups	%xmm0, -0x40(%rbp)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x20(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	-0x50(%rbp), %xmm1
               	pxor	%xmm1, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	leaq	-0x80(%rbp), %rax
               	leaq	0x10(%rax), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	-0x60(%rbp), %xmm1
               	pxor	%xmm1, %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	leaq	-0x80(%rbp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	movups	-0x70(%rbp), %xmm1
               	pxor	%xmm1, %xmm0
               	movups	%xmm0, -0x70(%rbp)
               	leaq	-0x80(%rbp), %rcx
               	movups	-0x80(%rbp), %xmm0
               	movups	0x50(%rsp), %xmm14
               	pxor	%xmm14, %xmm0
               	movups	%xmm0, -0x80(%rbp)
               	movq	-0x20(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x20(%rcx), %xmm14
               	movups	%xmm14, 0x20(%rax)
               	movups	0x30(%rcx), %xmm14
               	movups	%xmm14, 0x30(%rax)
               	movups	0x40(%rcx), %xmm14
               	movups	%xmm14, 0x40(%rax)
               	leave
               	retq

<update_scalar>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x58, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movzbq	(%rsi), %rdx
               	leaq	0x40(%rdi), %rax
               	movzbq	(%rax), %rcx
               	movq	%rcx, %r8
               	shlq	%r8
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%r8, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	movq	%rdx, %r9
               	xorq	%rcx, %r9
               	movzbq	0x1(%rsi), %rdx
               	movzbq	0x1(%rax), %rcx
               	movq	%rcx, %r8
               	shlq	%r8
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%r8, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	movq	%rdx, %rbx
               	xorq	%rcx, %rbx
               	movzbq	0x2(%rsi), %rdx
               	movzbq	0x2(%rax), %rcx
               	movq	%rcx, %r8
               	shlq	%r8
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%r8, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	movq	%rdx, %r12
               	xorq	%rcx, %r12
               	movzbq	0x3(%rsi), %rdx
               	movzbq	0x3(%rax), %rcx
               	movq	%rcx, %r8
               	shlq	%r8
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%r8, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	movq	%rdx, %r13
               	xorq	%rcx, %r13
               	movzbq	0x4(%rsi), %rdx
               	movzbq	0x4(%rax), %rcx
               	movq	%rcx, %r8
               	shlq	%r8
               	shrq	$0x7, %rcx
               	imulq	$0x1b, %rcx, %rcx
               	xorq	%r8, %rcx
               	xorq	$0x63, %rcx
               	andq	$0xff, %rcx
               	movq	%rdx, %r14
               	xorq	%rcx, %r14
               	movzbq	0x5(%rsi), %rcx
               	movzbq	0x5(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r15
               	xorq	%rax, %r15
               	movzbq	0x6(%rsi), %rcx
               	leaq	0x40(%rdi), %rax
               	movzbq	0x6(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x78(%rsp)
               	movzbq	0x7(%rsi), %rcx
               	leaq	0x40(%rdi), %rax
               	movzbq	0x7(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x70(%rsp)
               	movzbq	0x8(%rsi), %rcx
               	leaq	0x40(%rdi), %rax
               	movzbq	0x8(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x68(%rsp)
               	movzbq	0x9(%rsi), %rcx
               	leaq	0x40(%rdi), %rax
               	movzbq	0x9(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x60(%rsp)
               	movzbq	0xa(%rsi), %rcx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xa(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x58(%rsp)
               	movzbq	0xb(%rsi), %rcx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xb(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x50(%rsp)
               	movzbq	0xc(%rsi), %rcx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xc(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x48(%rsp)
               	movzbq	0xd(%rsi), %rcx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xd(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x40(%rsp)
               	movzbq	0xe(%rsi), %rcx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xe(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x38(%rsp)
               	movzbq	0xf(%rsi), %rcx
               	leaq	0x40(%rdi), %rax
               	movzbq	0xf(%rax), %rax
               	movq	%rax, %rdx
               	shlq	%rdx
               	shrq	$0x7, %rax
               	imulq	$0x1b, %rax, %rax
               	xorq	%rdx, %rax
               	xorq	$0x63, %rax
               	andq	$0xff, %rax
               	movq	%rcx, %r10
               	xorq	%rax, %r10
               	movq	%r10, 0x30(%rsp)
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, (%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x1(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x1(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x1(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x2(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x2(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x2(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x3(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x3(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x3(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x4(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x4(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x4(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x5(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x5(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x5(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x6(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x6(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x6(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x7(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x7(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x7(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x8(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x8(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x8(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0x9(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0x9(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0x9(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xa(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xa(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0xa(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xb(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xb(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0xb(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xc(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xc(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0xc(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xd(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xd(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0xd(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xe(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xe(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0xe(%rcx)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rdi, %rcx
               	movzbq	0xf(%rcx), %rsi
               	leaq	-0x1(%rax), %rdx
               	shlq	$0x4, %rdx
               	addq	%rdi, %rdx
               	movzbq	0xf(%rdx), %rdx
               	movq	%rdx, %r8
               	shlq	%r8
               	shrq	$0x7, %rdx
               	imulq	$0x1b, %rdx, %rdx
               	xorq	%r8, %rdx
               	xorq	$0x63, %rdx
               	andq	$0xff, %rdx
               	xorq	%rsi, %rdx
               	movb	%dl, 0xf(%rcx)
               	decq	%rax
               	testl	%eax, %eax
               	jg	<addr>
               	movzbq	(%rdi), %rax
               	xorq	%r9, %rax
               	movb	%al, (%rdi)
               	movzbq	0x1(%rdi), %rax
               	xorq	%rbx, %rax
               	movb	%al, 0x1(%rdi)
               	movzbq	0x2(%rdi), %rax
               	xorq	%r12, %rax
               	movb	%al, 0x2(%rdi)
               	movzbq	0x3(%rdi), %rax
               	xorq	%r13, %rax
               	movb	%al, 0x3(%rdi)
               	movzbq	0x4(%rdi), %rax
               	xorq	%r14, %rax
               	movb	%al, 0x4(%rdi)
               	movzbq	0x5(%rdi), %rax
               	xorq	%r15, %rax
               	movb	%al, 0x5(%rdi)
               	movzbq	0x6(%rdi), %rax
               	xorq	0x78(%rsp), %rax
               	movb	%al, 0x6(%rdi)
               	movzbq	0x7(%rdi), %rax
               	xorq	0x70(%rsp), %rax
               	movb	%al, 0x7(%rdi)
               	movzbq	0x8(%rdi), %rax
               	xorq	0x68(%rsp), %rax
               	movb	%al, 0x8(%rdi)
               	movzbq	0x9(%rdi), %rax
               	xorq	0x60(%rsp), %rax
               	movb	%al, 0x9(%rdi)
               	movzbq	0xa(%rdi), %rax
               	xorq	0x58(%rsp), %rax
               	movb	%al, 0xa(%rdi)
               	movzbq	0xb(%rdi), %rax
               	xorq	0x50(%rsp), %rax
               	movb	%al, 0xb(%rdi)
               	movzbq	0xc(%rdi), %rax
               	xorq	0x48(%rsp), %rax
               	movb	%al, 0xc(%rdi)
               	movzbq	0xd(%rdi), %rax
               	xorq	0x40(%rsp), %rax
               	movb	%al, 0xd(%rdi)
               	movzbq	0xe(%rdi), %rax
               	xorq	0x38(%rsp), %rax
               	movb	%al, 0xe(%rdi)
               	movzbq	0xf(%rdi), %rax
               	xorq	0x30(%rsp), %rax
               	movb	%al, 0xf(%rdi)
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<run_chunk>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xc8, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, %r12
               	movq	%rdx, %r15
               	movq	%rsi, %r14
               	leaq	-0x70(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movzbq	(%r12), %rax
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm0
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	movzbq	0x1(%r12), %rax
               	vpinsrb	$0x1, %eax, %xmm0, %xmm0
               	movzbq	0x2(%r12), %rax
               	vpinsrb	$0x2, %eax, %xmm0, %xmm0
               	movzbq	0x3(%r12), %rax
               	vpinsrb	$0x3, %eax, %xmm0, %xmm0
               	movzbq	0x4(%r12), %rax
               	vpinsrb	$0x4, %eax, %xmm0, %xmm0
               	movzbq	0x5(%r12), %rax
               	vpinsrb	$0x5, %eax, %xmm0, %xmm0
               	movzbq	0x6(%r12), %rax
               	vpinsrb	$0x6, %eax, %xmm0, %xmm0
               	movzbq	0x7(%r12), %rax
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	movzbq	0x8(%r12), %rax
               	vpinsrb	$0x8, %eax, %xmm0, %xmm0
               	movzbq	0x9(%r12), %rax
               	vpinsrb	$0x9, %eax, %xmm0, %xmm0
               	movzbq	0xa(%r12), %rax
               	vpinsrb	$0xa, %eax, %xmm0, %xmm0
               	movzbq	0xb(%r12), %rax
               	vpinsrb	$0xb, %eax, %xmm0, %xmm0
               	movzbq	0xc(%r12), %rax
               	vpinsrb	$0xc, %eax, %xmm0, %xmm0
               	movzbq	0xd(%r12), %rax
               	vpinsrb	$0xd, %eax, %xmm0, %xmm0
               	movzbq	0xe(%r12), %rax
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	movzbq	0xf(%r12), %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	movups	%xmm0, -0x70(%rbp)
               	leaq	0x10(%r12), %rax
               	movzbq	(%rax), %rcx
               	vpinsrb	$0x0, %ecx, %xmm0, %xmm0
               	movzbq	0x1(%rax), %rcx
               	vpinsrb	$0x1, %ecx, %xmm0, %xmm0
               	movzbq	0x2(%rax), %rcx
               	vpinsrb	$0x2, %ecx, %xmm0, %xmm0
               	movzbq	0x3(%rax), %rcx
               	vpinsrb	$0x3, %ecx, %xmm0, %xmm0
               	movzbq	0x4(%rax), %rcx
               	vpinsrb	$0x4, %ecx, %xmm0, %xmm0
               	movzbq	0x5(%rax), %rcx
               	vpinsrb	$0x5, %ecx, %xmm0, %xmm0
               	movzbq	0x6(%rax), %rcx
               	vpinsrb	$0x6, %ecx, %xmm0, %xmm0
               	movzbq	0x7(%rax), %rcx
               	vpinsrb	$0x7, %ecx, %xmm0, %xmm0
               	movzbq	0x8(%rax), %rcx
               	vpinsrb	$0x8, %ecx, %xmm0, %xmm0
               	movzbq	0x9(%rax), %rcx
               	vpinsrb	$0x9, %ecx, %xmm0, %xmm0
               	movzbq	0xa(%rax), %rcx
               	vpinsrb	$0xa, %ecx, %xmm0, %xmm0
               	movzbq	0xb(%rax), %rcx
               	vpinsrb	$0xb, %ecx, %xmm0, %xmm0
               	movzbq	0xc(%rax), %rcx
               	vpinsrb	$0xc, %ecx, %xmm0, %xmm0
               	movzbq	0xd(%rax), %rcx
               	vpinsrb	$0xd, %ecx, %xmm0, %xmm0
               	movzbq	0xe(%rax), %rcx
               	vpinsrb	$0xe, %ecx, %xmm0, %xmm0
               	movzbq	0xf(%rax), %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	movups	%xmm0, -0x60(%rbp)
               	leaq	0x20(%r12), %rax
               	movzbq	(%rax), %rcx
               	vpinsrb	$0x0, %ecx, %xmm0, %xmm0
               	movzbq	0x1(%rax), %rcx
               	vpinsrb	$0x1, %ecx, %xmm0, %xmm0
               	movzbq	0x2(%rax), %rcx
               	vpinsrb	$0x2, %ecx, %xmm0, %xmm0
               	movzbq	0x3(%rax), %rcx
               	vpinsrb	$0x3, %ecx, %xmm0, %xmm0
               	movzbq	0x4(%rax), %rcx
               	vpinsrb	$0x4, %ecx, %xmm0, %xmm0
               	movzbq	0x5(%rax), %rcx
               	vpinsrb	$0x5, %ecx, %xmm0, %xmm0
               	movzbq	0x6(%rax), %rcx
               	vpinsrb	$0x6, %ecx, %xmm0, %xmm0
               	movzbq	0x7(%rax), %rcx
               	vpinsrb	$0x7, %ecx, %xmm0, %xmm0
               	movzbq	0x8(%rax), %rcx
               	vpinsrb	$0x8, %ecx, %xmm0, %xmm0
               	movzbq	0x9(%rax), %rcx
               	vpinsrb	$0x9, %ecx, %xmm0, %xmm0
               	movzbq	0xa(%rax), %rcx
               	vpinsrb	$0xa, %ecx, %xmm0, %xmm0
               	movzbq	0xb(%rax), %rcx
               	vpinsrb	$0xb, %ecx, %xmm0, %xmm0
               	movzbq	0xc(%rax), %rcx
               	vpinsrb	$0xc, %ecx, %xmm0, %xmm0
               	movzbq	0xd(%rax), %rcx
               	vpinsrb	$0xd, %ecx, %xmm0, %xmm0
               	movzbq	0xe(%rax), %rcx
               	vpinsrb	$0xe, %ecx, %xmm0, %xmm0
               	movzbq	0xf(%rax), %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	movups	%xmm0, -0x50(%rbp)
               	leaq	0x30(%r12), %rax
               	movzbq	(%rax), %rcx
               	vpinsrb	$0x0, %ecx, %xmm0, %xmm0
               	movzbq	0x1(%rax), %rcx
               	vpinsrb	$0x1, %ecx, %xmm0, %xmm0
               	movzbq	0x2(%rax), %rcx
               	vpinsrb	$0x2, %ecx, %xmm0, %xmm0
               	movzbq	0x3(%rax), %rcx
               	vpinsrb	$0x3, %ecx, %xmm0, %xmm0
               	movzbq	0x4(%rax), %rcx
               	vpinsrb	$0x4, %ecx, %xmm0, %xmm0
               	movzbq	0x5(%rax), %rcx
               	vpinsrb	$0x5, %ecx, %xmm0, %xmm0
               	movzbq	0x6(%rax), %rcx
               	vpinsrb	$0x6, %ecx, %xmm0, %xmm0
               	movzbq	0x7(%rax), %rcx
               	vpinsrb	$0x7, %ecx, %xmm0, %xmm0
               	movzbq	0x8(%rax), %rcx
               	vpinsrb	$0x8, %ecx, %xmm0, %xmm0
               	movzbq	0x9(%rax), %rcx
               	vpinsrb	$0x9, %ecx, %xmm0, %xmm0
               	movzbq	0xa(%rax), %rcx
               	vpinsrb	$0xa, %ecx, %xmm0, %xmm0
               	movzbq	0xb(%rax), %rcx
               	vpinsrb	$0xb, %ecx, %xmm0, %xmm0
               	movzbq	0xc(%rax), %rcx
               	vpinsrb	$0xc, %ecx, %xmm0, %xmm0
               	movzbq	0xd(%rax), %rcx
               	vpinsrb	$0xd, %ecx, %xmm0, %xmm0
               	movzbq	0xe(%rax), %rcx
               	vpinsrb	$0xe, %ecx, %xmm0, %xmm0
               	movzbq	0xf(%rax), %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	movups	%xmm0, -0x40(%rbp)
               	leaq	0x40(%r12), %rax
               	movzbq	(%rax), %rcx
               	vpinsrb	$0x0, %ecx, %xmm0, %xmm0
               	movzbq	0x1(%rax), %rcx
               	vpinsrb	$0x1, %ecx, %xmm0, %xmm0
               	movzbq	0x2(%rax), %rcx
               	vpinsrb	$0x2, %ecx, %xmm0, %xmm0
               	movzbq	0x3(%rax), %rcx
               	vpinsrb	$0x3, %ecx, %xmm0, %xmm0
               	movzbq	0x4(%rax), %rcx
               	vpinsrb	$0x4, %ecx, %xmm0, %xmm0
               	movzbq	0x5(%rax), %rcx
               	vpinsrb	$0x5, %ecx, %xmm0, %xmm0
               	movzbq	0x6(%rax), %rcx
               	vpinsrb	$0x6, %ecx, %xmm0, %xmm0
               	movzbq	0x7(%rax), %rcx
               	vpinsrb	$0x7, %ecx, %xmm0, %xmm0
               	movzbq	0x8(%rax), %rcx
               	vpinsrb	$0x8, %ecx, %xmm0, %xmm0
               	movzbq	0x9(%rax), %rcx
               	vpinsrb	$0x9, %ecx, %xmm0, %xmm0
               	movzbq	0xa(%rax), %rcx
               	vpinsrb	$0xa, %ecx, %xmm0, %xmm0
               	movzbq	0xb(%rax), %rcx
               	vpinsrb	$0xb, %ecx, %xmm0, %xmm0
               	movzbq	0xc(%rax), %rcx
               	vpinsrb	$0xc, %ecx, %xmm0, %xmm0
               	movzbq	0xd(%rax), %rcx
               	vpinsrb	$0xd, %ecx, %xmm0, %xmm0
               	movzbq	0xe(%rax), %rcx
               	vpinsrb	$0xe, %ecx, %xmm0, %xmm0
               	movzbq	0xf(%rax), %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	movups	%xmm0, -0x30(%rbp)
               	movq	-0x70(%rbp), %rax
               	movq	-0x68(%rbp), %rcx
               	movq	-0x60(%rbp), %rdx
               	movq	-0x58(%rbp), %rsi
               	movq	-0x50(%rbp), %rdi
               	movq	-0x48(%rbp), %r8
               	movq	-0x40(%rbp), %r9
               	movq	-0x38(%rbp), %rbx
               	movq	-0x30(%rbp), %r13
               	movq	-0x28(%rbp), %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	%rax, -0xc0(%rbp)
               	movq	%rcx, -0xb8(%rbp)
               	movq	%rdx, -0xb0(%rbp)
               	movq	%rsi, -0xa8(%rbp)
               	movq	%rdi, -0xa0(%rbp)
               	movq	%r8, -0x98(%rbp)
               	movq	%r9, -0x90(%rbp)
               	movq	%rbx, -0x88(%rbp)
               	movq	%r13, -0x80(%rbp)
               	movq	0xe8(%rsp), %r10
               	movq	%r10, -0x78(%rbp)
               	xorl	%ebx, %ebx
               	cmpl	%r15d, %ebx
               	jge	<addr>
               	leaq	-0xc0(%rbp), %r13
               	leaq	-0x70(%rbp), %rdi
               	movq	%rbx, %rax
               	shlq	$0x4, %rax
               	movslq	%eax, %rax
               	addq	%r14, %rax
               	movzbq	(%rax), %rcx
               	movups	0xe0(%rsp), %xmm0
               	vpinsrb	$0x0, %ecx, %xmm0, %xmm0
               	movzbq	0x1(%rax), %rcx
               	vpinsrb	$0x1, %ecx, %xmm0, %xmm0
               	movzbq	0x2(%rax), %rcx
               	vpinsrb	$0x2, %ecx, %xmm0, %xmm0
               	movzbq	0x3(%rax), %rcx
               	vpinsrb	$0x3, %ecx, %xmm0, %xmm0
               	movzbq	0x4(%rax), %rcx
               	vpinsrb	$0x4, %ecx, %xmm0, %xmm0
               	movzbq	0x5(%rax), %rcx
               	vpinsrb	$0x5, %ecx, %xmm0, %xmm0
               	movzbq	0x6(%rax), %rcx
               	vpinsrb	$0x6, %ecx, %xmm0, %xmm0
               	movzbq	0x7(%rax), %rcx
               	vpinsrb	$0x7, %ecx, %xmm0, %xmm0
               	movzbq	0x8(%rax), %rcx
               	vpinsrb	$0x8, %ecx, %xmm0, %xmm0
               	movzbq	0x9(%rax), %rcx
               	vpinsrb	$0x9, %ecx, %xmm0, %xmm0
               	movzbq	0xa(%rax), %rcx
               	vpinsrb	$0xa, %ecx, %xmm0, %xmm0
               	movzbq	0xb(%rax), %rcx
               	vpinsrb	$0xb, %ecx, %xmm0, %xmm0
               	movzbq	0xc(%rax), %rcx
               	vpinsrb	$0xc, %ecx, %xmm0, %xmm0
               	movzbq	0xd(%rax), %rcx
               	vpinsrb	$0xd, %ecx, %xmm0, %xmm0
               	movzbq	0xe(%rax), %rcx
               	vpinsrb	$0xe, %ecx, %xmm0, %xmm0
               	movzbq	0xf(%rax), %rax
               	movapd	%xmm0, %xmm14
               	vpinsrb	$0xf, %eax, %xmm14, %xmm14
               	movups	%xmm14, 0xe0(%rsp)
               	movups	0xe0(%rsp), %xmm14
               	movups	%xmm14, -0x20(%rbp)
               	leaq	-0x20(%rbp), %r9
               	subq	$0x50, %rsp
               	movq	%r13, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x30(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x38(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	0x40(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x48(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	addq	$0x50, %rsp
               	leaq	-0x70(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r13)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r13)
               	movups	0x20(%rax), %xmm14
               	movups	%xmm14, 0x20(%r13)
               	movups	0x30(%rax), %xmm14
               	movups	%xmm14, 0x30(%r13)
               	movups	0x40(%rax), %xmm14
               	movups	%xmm14, 0x40(%r13)
               	incq	%rbx
               	cmpl	%r15d, %ebx
               	jl	<addr>
               	leaq	-0xc0(%rbp), %r9
               	subq	$0x50, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x30(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x38(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	0x40(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x48(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	%r12, %rdi
               	callq	<addr>
               	addq	$0x50, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x2d0, %rsp            # imm = 0x2D0
               	pushq	%r12
               	pushq	%rbx
               	xorl	%eax, %eax
               	leaq	-0x218(%rbp), %rcx
               	imulq	$0x7, %rax, %rdx
               	incq	%rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0xd8(%rbp), %rcx
               	imulq	$0x1f, %rax, %rdx
               	addq	$0x9, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x80, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x1c8(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	-0x218(%rbp), %rdx
               	movzbq	(%rdx,%rcx), %rdx
               	movb	%dl, (%rsi)
               	leaq	-0x218(%rbp), %rdx
               	leaq	0x1(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdi
               	movb	%dil, 0x1(%rsi)
               	leaq	-0x1c8(%rbp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x2(%rcx), %r8
               	movzbq	(%rdx,%r8), %r8
               	movb	%r8b, 0x2(%rdi)
               	addq	%rcx, %rsi
               	leaq	0x3(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdx
               	movb	%dl, 0x3(%rsi)
               	leaq	-0x1c8(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	-0x218(%rbp), %rsi
               	addq	$0x4, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	movb	%cl, 0x4(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	0x5(%rcx), %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	movb	%dl, 0x5(%rdi)
               	leaq	-0x218(%rbp), %rdx
               	leaq	0x6(%rcx), %rsi
               	movzbq	(%rdx,%rsi), %rsi
               	movb	%sil, 0x6(%rdi)
               	leaq	-0x1c8(%rbp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x7(%rcx), %r8
               	movzbq	(%rdx,%r8), %r8
               	movb	%r8b, 0x7(%rdi)
               	addq	%rcx, %rsi
               	leaq	0x8(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdx
               	movb	%dl, 0x8(%rsi)
               	leaq	-0x1c8(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	-0x218(%rbp), %rsi
               	addq	$0x9, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	movb	%cl, 0x9(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	0xa(%rcx), %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	movb	%dl, 0xa(%rdi)
               	leaq	-0x218(%rbp), %rdx
               	leaq	0xb(%rcx), %rsi
               	movzbq	(%rdx,%rsi), %rsi
               	movb	%sil, 0xb(%rdi)
               	leaq	-0x1c8(%rbp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0xc(%rcx), %r8
               	movzbq	(%rdx,%r8), %r8
               	movb	%r8b, 0xc(%rdi)
               	addq	%rcx, %rsi
               	leaq	0xd(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdx
               	movb	%dl, 0xd(%rsi)
               	leaq	-0x1c8(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	-0x218(%rbp), %rsi
               	addq	$0xe, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	movb	%cl, 0xe(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rdx
               	addq	$0xf, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	movb	%cl, 0xf(%rdx)
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rsi
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x10(%rax), %rsi
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x20(%rax), %rsi
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x30(%rax), %rsi
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x40(%rax), %rsi
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x50(%rax), %rsi
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x60(%rax), %rsi
               	callq	<addr>
               	leaq	-0x1c8(%rbp), %rbx
               	leaq	-0xd8(%rbp), %rax
               	leaq	0x70(%rax), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	leaq	-0x178(%rbp), %rcx
               	leaq	-0x218(%rbp), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	leaq	-0x178(%rbp), %r12
               	leaq	-0xd8(%rbp), %rsi
               	movl	$0x8, %edx
               	movq	%r12, %rdi
               	callq	<addr>
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	movq	%rdx, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rcx,%rax), %rsi
               	movzbq	(%r12,%rsi), %rsi
               	addq	%rbx, %rcx
               	movzbq	(%rcx,%rax), %rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x5, %edx
               	jl	<addr>
               	xorl	%ebx, %ebx
               	xorl	%eax, %eax
               	leaq	-0x128(%rbp), %rcx
               	leaq	-0x218(%rbp), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	leaq	-0x128(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rsi
               	movq	%rbx, %rdx
               	callq	<addr>
               	leaq	-0x128(%rbp), %rdi
               	leaq	-0xd8(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rax,%rcx), %rsi
               	movl	$0x8, %edx
               	subq	%rbx, %rdx
               	callq	<addr>
               	xorl	%eax, %eax
               	leaq	-0x128(%rbp), %rcx
               	movzbq	(%rcx,%rax), %rcx
               	leaq	-0x178(%rbp), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	cmpl	%edx, %ecx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x50, %eax
               	jl	<addr>
               	incq	%rbx
               	cmpl	$0x8, %ebx
               	jle	<addr>
               	leaq	-0x218(%rbp), %rcx
               	movzbq	-0x218(%rbp), %rax
               	xorl	%edx, %edx
               	movq	%rdx, %xmm0
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	movzbq	-0x217(%rbp), %rax
               	vpinsrb	$0x1, %eax, %xmm0, %xmm0
               	movzbq	-0x216(%rbp), %rax
               	vpinsrb	$0x2, %eax, %xmm0, %xmm0
               	movzbq	-0x215(%rbp), %rax
               	vpinsrb	$0x3, %eax, %xmm0, %xmm0
               	movzbq	-0x214(%rbp), %rax
               	vpinsrb	$0x4, %eax, %xmm0, %xmm0
               	movzbq	-0x213(%rbp), %rax
               	vpinsrb	$0x5, %eax, %xmm0, %xmm0
               	movzbq	-0x212(%rbp), %rax
               	vpinsrb	$0x6, %eax, %xmm0, %xmm0
               	movzbq	-0x211(%rbp), %rax
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	movzbq	-0x210(%rbp), %rax
               	vpinsrb	$0x8, %eax, %xmm0, %xmm0
               	movzbq	-0x20f(%rbp), %rax
               	vpinsrb	$0x9, %eax, %xmm0, %xmm0
               	movzbq	-0x20e(%rbp), %rax
               	vpinsrb	$0xa, %eax, %xmm0, %xmm0
               	movzbq	-0x20d(%rbp), %rax
               	vpinsrb	$0xb, %eax, %xmm0, %xmm0
               	movzbq	-0x20c(%rbp), %rax
               	vpinsrb	$0xc, %eax, %xmm0, %xmm0
               	movzbq	-0x20b(%rbp), %rax
               	vpinsrb	$0xd, %eax, %xmm0, %xmm0
               	movzbq	-0x20a(%rbp), %rax
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	movzbq	-0x209(%rbp), %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	leaq	0x10(%rcx), %rax
               	movzbq	(%rax), %rdx
               	movapd	%xmm0, %xmm1
               	vpinsrb	$0x0, %edx, %xmm1, %xmm1
               	movzbq	0x1(%rax), %rdx
               	vpinsrb	$0x1, %edx, %xmm1, %xmm1
               	movzbq	0x2(%rax), %rdx
               	vpinsrb	$0x2, %edx, %xmm1, %xmm1
               	movzbq	0x3(%rax), %rdx
               	vpinsrb	$0x3, %edx, %xmm1, %xmm1
               	movzbq	0x4(%rax), %rdx
               	vpinsrb	$0x4, %edx, %xmm1, %xmm1
               	movzbq	0x5(%rax), %rdx
               	vpinsrb	$0x5, %edx, %xmm1, %xmm1
               	movzbq	0x6(%rax), %rdx
               	vpinsrb	$0x6, %edx, %xmm1, %xmm1
               	movzbq	0x7(%rax), %rdx
               	vpinsrb	$0x7, %edx, %xmm1, %xmm1
               	movzbq	0x8(%rax), %rdx
               	vpinsrb	$0x8, %edx, %xmm1, %xmm1
               	movzbq	0x9(%rax), %rdx
               	vpinsrb	$0x9, %edx, %xmm1, %xmm1
               	movzbq	0xa(%rax), %rdx
               	vpinsrb	$0xa, %edx, %xmm1, %xmm1
               	movzbq	0xb(%rax), %rdx
               	vpinsrb	$0xb, %edx, %xmm1, %xmm1
               	movzbq	0xc(%rax), %rdx
               	vpinsrb	$0xc, %edx, %xmm1, %xmm1
               	movzbq	0xd(%rax), %rdx
               	vpinsrb	$0xd, %edx, %xmm1, %xmm1
               	movzbq	0xe(%rax), %rdx
               	vpinsrb	$0xe, %edx, %xmm1, %xmm1
               	movzbq	0xf(%rax), %rax
               	vpinsrb	$0xf, %eax, %xmm1, %xmm1
               	leaq	0x20(%rcx), %rax
               	movzbq	(%rax), %rcx
               	movapd	%xmm1, %xmm2
               	vpinsrb	$0x0, %ecx, %xmm2, %xmm2
               	movzbq	0x1(%rax), %rcx
               	vpinsrb	$0x1, %ecx, %xmm2, %xmm2
               	movzbq	0x2(%rax), %rcx
               	vpinsrb	$0x2, %ecx, %xmm2, %xmm2
               	movzbq	0x3(%rax), %rcx
               	vpinsrb	$0x3, %ecx, %xmm2, %xmm2
               	movzbq	0x4(%rax), %rcx
               	vpinsrb	$0x4, %ecx, %xmm2, %xmm2
               	movzbq	0x5(%rax), %rcx
               	vpinsrb	$0x5, %ecx, %xmm2, %xmm2
               	movzbq	0x6(%rax), %rcx
               	vpinsrb	$0x6, %ecx, %xmm2, %xmm2
               	movzbq	0x7(%rax), %rcx
               	vpinsrb	$0x7, %ecx, %xmm2, %xmm2
               	movzbq	0x8(%rax), %rcx
               	vpinsrb	$0x8, %ecx, %xmm2, %xmm2
               	movzbq	0x9(%rax), %rcx
               	vpinsrb	$0x9, %ecx, %xmm2, %xmm2
               	movzbq	0xa(%rax), %rcx
               	vpinsrb	$0xa, %ecx, %xmm2, %xmm2
               	movzbq	0xb(%rax), %rcx
               	vpinsrb	$0xb, %ecx, %xmm2, %xmm2
               	movzbq	0xc(%rax), %rcx
               	vpinsrb	$0xc, %ecx, %xmm2, %xmm2
               	movzbq	0xd(%rax), %rcx
               	vpinsrb	$0xd, %ecx, %xmm2, %xmm2
               	movzbq	0xe(%rax), %rcx
               	vpinsrb	$0xe, %ecx, %xmm2, %xmm2
               	movzbq	0xf(%rax), %rax
               	vpinsrb	$0xf, %eax, %xmm2, %xmm2
               	leaq	-0x218(%rbp), %rcx
               	leaq	0x30(%rcx), %rax
               	movzbq	(%rax), %rdx
               	movapd	%xmm2, %xmm3
               	vpinsrb	$0x0, %edx, %xmm3, %xmm3
               	movzbq	0x1(%rax), %rdx
               	vpinsrb	$0x1, %edx, %xmm3, %xmm3
               	movzbq	0x2(%rax), %rdx
               	vpinsrb	$0x2, %edx, %xmm3, %xmm3
               	movzbq	0x3(%rax), %rdx
               	vpinsrb	$0x3, %edx, %xmm3, %xmm3
               	movzbq	0x4(%rax), %rdx
               	vpinsrb	$0x4, %edx, %xmm3, %xmm3
               	movzbq	0x5(%rax), %rdx
               	vpinsrb	$0x5, %edx, %xmm3, %xmm3
               	movzbq	0x6(%rax), %rdx
               	vpinsrb	$0x6, %edx, %xmm3, %xmm3
               	movzbq	0x7(%rax), %rdx
               	vpinsrb	$0x7, %edx, %xmm3, %xmm3
               	movzbq	0x8(%rax), %rdx
               	vpinsrb	$0x8, %edx, %xmm3, %xmm3
               	movzbq	0x9(%rax), %rdx
               	vpinsrb	$0x9, %edx, %xmm3, %xmm3
               	movzbq	0xa(%rax), %rdx
               	vpinsrb	$0xa, %edx, %xmm3, %xmm3
               	movzbq	0xb(%rax), %rdx
               	vpinsrb	$0xb, %edx, %xmm3, %xmm3
               	movzbq	0xc(%rax), %rdx
               	vpinsrb	$0xc, %edx, %xmm3, %xmm3
               	movzbq	0xd(%rax), %rdx
               	vpinsrb	$0xd, %edx, %xmm3, %xmm3
               	movzbq	0xe(%rax), %rdx
               	vpinsrb	$0xe, %edx, %xmm3, %xmm3
               	movzbq	0xf(%rax), %rax
               	vpinsrb	$0xf, %eax, %xmm3, %xmm3
               	leaq	0x40(%rcx), %rax
               	movzbq	(%rax), %rcx
               	movapd	%xmm3, %xmm4
               	vpinsrb	$0x0, %ecx, %xmm4, %xmm4
               	movzbq	0x1(%rax), %rcx
               	vpinsrb	$0x1, %ecx, %xmm4, %xmm4
               	movzbq	0x2(%rax), %rcx
               	vpinsrb	$0x2, %ecx, %xmm4, %xmm4
               	movzbq	0x3(%rax), %rcx
               	vpinsrb	$0x3, %ecx, %xmm4, %xmm4
               	movzbq	0x4(%rax), %rcx
               	vpinsrb	$0x4, %ecx, %xmm4, %xmm4
               	movzbq	0x5(%rax), %rcx
               	vpinsrb	$0x5, %ecx, %xmm4, %xmm4
               	movzbq	0x6(%rax), %rcx
               	vpinsrb	$0x6, %ecx, %xmm4, %xmm4
               	movzbq	0x7(%rax), %rcx
               	vpinsrb	$0x7, %ecx, %xmm4, %xmm4
               	movzbq	0x8(%rax), %rcx
               	vpinsrb	$0x8, %ecx, %xmm4, %xmm4
               	movzbq	0x9(%rax), %rcx
               	vpinsrb	$0x9, %ecx, %xmm4, %xmm4
               	movzbq	0xa(%rax), %rcx
               	vpinsrb	$0xa, %ecx, %xmm4, %xmm4
               	movzbq	0xb(%rax), %rcx
               	vpinsrb	$0xb, %ecx, %xmm4, %xmm4
               	movzbq	0xc(%rax), %rcx
               	vpinsrb	$0xc, %ecx, %xmm4, %xmm4
               	movzbq	0xd(%rax), %rcx
               	vpinsrb	$0xd, %ecx, %xmm4, %xmm4
               	movzbq	0xe(%rax), %rcx
               	vpinsrb	$0xe, %ecx, %xmm4, %xmm4
               	movzbq	0xf(%rax), %rax
               	vpinsrb	$0xf, %eax, %xmm4, %xmm4
               	leaq	-0x2d0(%rbp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movups	%xmm14, 0x20(%r9)
               	movups	%xmm14, 0x30(%r9)
               	movups	%xmm14, 0x40(%r9)
               	movups	%xmm0, -0x2d0(%rbp)
               	movups	%xmm1, -0x2c0(%rbp)
               	movups	%xmm2, -0x2b0(%rbp)
               	movups	%xmm3, -0x2a0(%rbp)
               	movups	%xmm4, -0x290(%rbp)
               	leaq	-0x280(%rbp), %rdi
               	movzbq	-0xd8(%rbp), %rax
               	movapd	%xmm4, %xmm0
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	movzbq	-0xd7(%rbp), %rax
               	vpinsrb	$0x1, %eax, %xmm0, %xmm0
               	movzbq	-0xd6(%rbp), %rax
               	vpinsrb	$0x2, %eax, %xmm0, %xmm0
               	movzbq	-0xd5(%rbp), %rax
               	vpinsrb	$0x3, %eax, %xmm0, %xmm0
               	movzbq	-0xd4(%rbp), %rax
               	vpinsrb	$0x4, %eax, %xmm0, %xmm0
               	movzbq	-0xd3(%rbp), %rax
               	vpinsrb	$0x5, %eax, %xmm0, %xmm0
               	movzbq	-0xd2(%rbp), %rax
               	vpinsrb	$0x6, %eax, %xmm0, %xmm0
               	movzbq	-0xd1(%rbp), %rax
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	movzbq	-0xd0(%rbp), %rax
               	vpinsrb	$0x8, %eax, %xmm0, %xmm0
               	movzbq	-0xcf(%rbp), %rax
               	vpinsrb	$0x9, %eax, %xmm0, %xmm0
               	movzbq	-0xce(%rbp), %rax
               	vpinsrb	$0xa, %eax, %xmm0, %xmm0
               	movzbq	-0xcd(%rbp), %rax
               	vpinsrb	$0xb, %eax, %xmm0, %xmm0
               	movzbq	-0xcc(%rbp), %rax
               	vpinsrb	$0xc, %eax, %xmm0, %xmm0
               	movzbq	-0xcb(%rbp), %rax
               	vpinsrb	$0xd, %eax, %xmm0, %xmm0
               	movzbq	-0xca(%rbp), %rax
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	movzbq	-0xc9(%rbp), %rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	leaq	-0x230(%rbp), %rax
               	movups	%xmm0, -0x230(%rbp)
               	subq	$0x50, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x30(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x38(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	0x40(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x48(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	addq	$0x50, %rsp
               	leaq	-0x280(%rbp), %r9
               	leaq	-0x128(%rbp), %rdi
               	subq	$0x50, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	0x20(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x28(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x30(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x38(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	movq	0x40(%r10), %r11
               	movq	%r11, 0x40(%rsp)
               	movq	0x48(%r10), %r11
               	movq	%r11, 0x48(%rsp)
               	callq	<addr>
               	addq	$0x50, %rsp
               	xorl	%eax, %eax
               	leaq	-0x50(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	-0x218(%rbp), %rdx
               	movzbq	(%rdx,%rcx), %rdx
               	movb	%dl, (%rsi)
               	leaq	-0x218(%rbp), %rdx
               	leaq	0x1(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdi
               	movb	%dil, 0x1(%rsi)
               	leaq	-0x50(%rbp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x2(%rcx), %r8
               	movzbq	(%rdx,%r8), %r8
               	movb	%r8b, 0x2(%rdi)
               	addq	%rcx, %rsi
               	leaq	0x3(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdx
               	movb	%dl, 0x3(%rsi)
               	leaq	-0x50(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	-0x218(%rbp), %rsi
               	addq	$0x4, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	movb	%cl, 0x4(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	0x5(%rcx), %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	movb	%dl, 0x5(%rdi)
               	leaq	-0x218(%rbp), %rdx
               	leaq	0x6(%rcx), %rsi
               	movzbq	(%rdx,%rsi), %rsi
               	movb	%sil, 0x6(%rdi)
               	leaq	-0x50(%rbp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0x7(%rcx), %r8
               	movzbq	(%rdx,%r8), %r8
               	movb	%r8b, 0x7(%rdi)
               	addq	%rcx, %rsi
               	leaq	0x8(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdx
               	movb	%dl, 0x8(%rsi)
               	leaq	-0x50(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	-0x218(%rbp), %rsi
               	addq	$0x9, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	movb	%cl, 0x9(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	0xa(%rcx), %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	movb	%dl, 0xa(%rdi)
               	leaq	-0x218(%rbp), %rdx
               	leaq	0xb(%rcx), %rsi
               	movzbq	(%rdx,%rsi), %rsi
               	movb	%sil, 0xb(%rdi)
               	leaq	-0x50(%rbp), %rsi
               	leaq	(%rsi,%rcx), %rdi
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	leaq	0xc(%rcx), %r8
               	movzbq	(%rdx,%r8), %r8
               	movb	%r8b, 0xc(%rdi)
               	addq	%rcx, %rsi
               	leaq	0xd(%rcx), %rdi
               	movzbq	(%rdx,%rdi), %rdx
               	movb	%dl, 0xd(%rsi)
               	leaq	-0x50(%rbp), %rdx
               	leaq	(%rdx,%rcx), %rdi
               	leaq	-0x218(%rbp), %rsi
               	addq	$0xe, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	movb	%cl, 0xe(%rdi)
               	movq	%rax, %rcx
               	shlq	$0x4, %rcx
               	addq	%rcx, %rdx
               	addq	$0xf, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	movb	%cl, 0xf(%rdx)
               	incq	%rax
               	cmpl	$0x5, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rbx
               	leaq	-0xd8(%rbp), %rsi
               	movq	%rbx, %rdi
               	callq	<addr>
               	xorl	%edx, %edx
               	xorl	%eax, %eax
               	leaq	-0x128(%rbp), %rsi
               	movq	%rdx, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rcx,%rax), %rdi
               	movzbq	(%rsi,%rdi), %rsi
               	addq	%rbx, %rcx
               	movzbq	(%rcx,%rax), %rcx
               	cmpl	%ecx, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	incq	%rdx
               	cmpl	$0x5, %edx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x14, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	leaq	0x2(%rbx), %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
               	movl	$0x1, %eax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
