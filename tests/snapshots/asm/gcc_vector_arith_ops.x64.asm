
gcc_vector_arith_ops.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	subq	$0x180, %rsp            # imm = 0x180
               	andq	$-0x20, %rsp
               	leaq	0x60(%rsp), %rdx
               	leaq	<rip>, %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rdx)
               	leaq	0x70(%rsp), %rsi
               	leaq	<rip>, %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rsi)
               	leaq	0x80(%rsp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	0x90(%rsp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	0xa0(%rsp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	0xb0(%rsp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	0xc0(%rsp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	0xd0(%rsp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	0xe0(%rsp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	0xf0(%rsp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	0x100(%rsp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	0x110(%rsp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	0x120(%rsp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	0x130(%rsp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	0x140(%rsp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	0x150(%rsp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %ymm14
               	vmovups	%ymm14, (%rax)
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	vpaddb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rcx
               	movzbq	0x70(%rsp,%rax), %r8
               	addq	%r8, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x10(%rbp,%rax)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	vpsubb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rcx
               	movzbq	0x70(%rsp,%rax), %rsi
               	subq	%rsi, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x10(%rbp,%rax)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	movzbq	0x60(%rsp), %rax
               	movzbq	0x70(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rax
               	movzbq	0x71(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rax
               	movzbq	0x72(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rax
               	movzbq	0x73(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rax
               	movzbq	0x74(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rax
               	movzbq	0x75(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rax
               	movzbq	0x76(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rax
               	movzbq	0x77(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rax
               	movzbq	0x78(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rax
               	movzbq	0x79(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rax
               	movzbq	0x7a(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rax
               	movzbq	0x7b(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rax
               	movzbq	0x7c(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rax
               	movzbq	0x7d(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rax
               	movzbq	0x7e(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rax
               	movzbq	0x7f(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x4f(%rsp)
               	leaq	0x160(%rsp), %rax
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rcx
               	movzbq	0x70(%rsp,%rax), %rsi
               	imulq	%rsi, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x160(%rsp,%rax), %rdx
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	movzbq	0x60(%rsp), %rax
               	movzbq	0x70(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%al, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rax
               	movzbq	0x71(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%al, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rax
               	movzbq	0x72(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%al, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rax
               	movzbq	0x73(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%al, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rax
               	movzbq	0x74(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%al, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rax
               	movzbq	0x75(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%al, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rax
               	movzbq	0x76(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%al, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rax
               	movzbq	0x77(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%al, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rax
               	movzbq	0x78(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%al, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rax
               	movzbq	0x79(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%al, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rax
               	movzbq	0x7a(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%al, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rax
               	movzbq	0x7b(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%al, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rax
               	movzbq	0x7c(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%al, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rax
               	movzbq	0x7d(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%al, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rax
               	movzbq	0x7e(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%al, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rax
               	movzbq	0x7f(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%al, 0x4f(%rsp)
               	leaq	0x160(%rsp), %rax
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movzbq	0x60(%rsp,%rcx), %rax
               	movzbq	0x70(%rsp,%rcx), %rdi
               	cltd
               	idivl	%edi
               	andq	$0xff, %rax
               	movb	%al, -0x10(%rbp,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x160(%rsp,%rax), %rdx
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	movzbq	0x60(%rsp), %rdi
               	movzbq	0x70(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdi
               	movzbq	0x71(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdi
               	movzbq	0x72(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdi
               	movzbq	0x73(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdi
               	movzbq	0x74(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdi
               	movzbq	0x75(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdi
               	movzbq	0x76(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdi
               	movzbq	0x77(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdi
               	movzbq	0x78(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdi
               	movzbq	0x79(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdi
               	movzbq	0x7a(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdi
               	movzbq	0x7b(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdi
               	movzbq	0x7c(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdi
               	movzbq	0x7d(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdi
               	movzbq	0x7e(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdi
               	movzbq	0x7f(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4f(%rsp)
               	leaq	0x160(%rsp), %rax
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movzbq	0x60(%rsp,%rcx), %rdi
               	movzbq	0x70(%rsp,%rcx), %r8
               	movl	%edi, %eax
               	cltd
               	idivl	%r8d
               	andq	$0xff, %rdx
               	movb	%dl, -0x10(%rbp,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x160(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	vpand	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rdx
               	movzbq	0x70(%rsp,%rax), %rsi
               	andq	%rsi, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	vpor	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rdx
               	movzbq	0x70(%rsp,%rax), %rsi
               	orq	%rsi, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	vpxor	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rdx
               	movzbq	0x70(%rsp,%rax), %rsi
               	xorq	%rsi, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x80(%rsp), %xmm0
               	movups	0x90(%rsp), %xmm1
               	vpaddb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movsbq	0x80(%rsp,%rax), %rdx
               	movsbq	0x90(%rsp,%rax), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x80(%rsp), %xmm0
               	movups	0x90(%rsp), %xmm1
               	vpsubb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movsbq	0x80(%rsp,%rax), %rdx
               	movsbq	0x90(%rsp,%rax), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rdx
               	movsbq	0x80(%rsp), %rax
               	movsbq	0x90(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x40(%rsp)
               	movsbq	0x81(%rsp), %rax
               	movsbq	0x91(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x41(%rsp)
               	movsbq	0x82(%rsp), %rax
               	movsbq	0x92(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x42(%rsp)
               	movsbq	0x83(%rsp), %rax
               	movsbq	0x93(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x43(%rsp)
               	movsbq	0x84(%rsp), %rax
               	movsbq	0x94(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x44(%rsp)
               	movsbq	0x85(%rsp), %rax
               	movsbq	0x95(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x45(%rsp)
               	movsbq	0x86(%rsp), %rax
               	movsbq	0x96(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x46(%rsp)
               	movsbq	0x87(%rsp), %rax
               	movsbq	0x97(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x47(%rsp)
               	movsbq	0x88(%rsp), %rax
               	movsbq	0x98(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x48(%rsp)
               	movsbq	0x89(%rsp), %rax
               	movsbq	0x99(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x49(%rsp)
               	movsbq	0x8a(%rsp), %rax
               	movsbq	0x9a(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x4a(%rsp)
               	movsbq	0x8b(%rsp), %rax
               	movsbq	0x9b(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x4b(%rsp)
               	movsbq	0x8c(%rsp), %rax
               	movsbq	0x9c(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x4c(%rsp)
               	movsbq	0x8d(%rsp), %rax
               	movsbq	0x9d(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x4d(%rsp)
               	movsbq	0x8e(%rsp), %rax
               	movsbq	0x9e(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x4e(%rsp)
               	movsbq	0x8f(%rsp), %rax
               	movsbq	0x9f(%rsp), %rsi
               	imulq	%rsi, %rax
               	movb	%al, 0x4f(%rsp)
               	leaq	0x160(%rsp), %rax
               	vmovups	(%rdx), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movsbq	0x80(%rsp,%rax), %rdx
               	movsbq	0x90(%rsp,%rax), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x160(%rsp,%rax), %rdx
               	movzbq	-0x10(%rbp,%rax), %rdi
               	nop
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	movsbq	0x80(%rsp), %rax
               	movsbq	0x90(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x40(%rsp)
               	movsbq	0x81(%rsp), %rax
               	movsbq	0x91(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x41(%rsp)
               	movsbq	0x82(%rsp), %rax
               	movsbq	0x92(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x42(%rsp)
               	movsbq	0x83(%rsp), %rax
               	movsbq	0x93(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x43(%rsp)
               	movsbq	0x84(%rsp), %rax
               	movsbq	0x94(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x44(%rsp)
               	movsbq	0x85(%rsp), %rax
               	movsbq	0x95(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x45(%rsp)
               	movsbq	0x86(%rsp), %rax
               	movsbq	0x96(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x46(%rsp)
               	movsbq	0x87(%rsp), %rax
               	movsbq	0x97(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x47(%rsp)
               	movsbq	0x88(%rsp), %rax
               	movsbq	0x98(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x48(%rsp)
               	movsbq	0x89(%rsp), %rax
               	movsbq	0x99(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x49(%rsp)
               	movsbq	0x8a(%rsp), %rax
               	movsbq	0x9a(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x4a(%rsp)
               	movsbq	0x8b(%rsp), %rax
               	movsbq	0x9b(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x4b(%rsp)
               	movsbq	0x8c(%rsp), %rax
               	movsbq	0x9c(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x4c(%rsp)
               	movsbq	0x8d(%rsp), %rax
               	movsbq	0x9d(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x4d(%rsp)
               	movsbq	0x8e(%rsp), %rax
               	movsbq	0x9e(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x4e(%rsp)
               	movsbq	0x8f(%rsp), %rax
               	movsbq	0x9f(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x4f(%rsp)
               	leaq	0x160(%rsp), %rax
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movsbq	0x80(%rsp,%rcx), %rax
               	movsbq	0x90(%rsp,%rcx), %rdi
               	cltd
               	idivl	%edi
               	movb	%al, -0x10(%rbp,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x160(%rsp,%rax), %rdx
               	movzbq	-0x10(%rbp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	movsbq	0x80(%rsp), %rdi
               	movsbq	0x90(%rsp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movb	%dl, 0x40(%rsp)
               	movsbq	0x81(%rsp), %rdi
               	movsbq	0x91(%rsp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movb	%dl, 0x41(%rsp)
               	movsbq	0x82(%rsp), %rdi
               	movsbq	0x92(%rsp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movb	%dl, 0x42(%rsp)
               	movsbq	0x83(%rsp), %rdi
               	movsbq	0x93(%rsp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movb	%dl, 0x43(%rsp)
               	movsbq	0x84(%rsp), %rdi
               	movsbq	0x94(%rsp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movb	%dl, 0x44(%rsp)
               	movsbq	0x85(%rsp), %rdi
               	movsbq	0x95(%rsp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movb	%dl, 0x45(%rsp)
               	movsbq	0x86(%rsp), %rdi
               	movsbq	0x96(%rsp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movb	%dl, 0x46(%rsp)
               	movsbq	0x87(%rsp), %rdi
               	movsbq	0x97(%rsp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movb	%dl, 0x47(%rsp)
               	movsbq	0x88(%rsp), %rdi
               	movsbq	0x98(%rsp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movb	%dl, 0x48(%rsp)
               	movsbq	0x89(%rsp), %rdi
               	movsbq	0x99(%rsp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movb	%dl, 0x49(%rsp)
               	movsbq	0x8a(%rsp), %rdi
               	movsbq	0x9a(%rsp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movb	%dl, 0x4a(%rsp)
               	movsbq	0x8b(%rsp), %rdi
               	movsbq	0x9b(%rsp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movb	%dl, 0x4b(%rsp)
               	movsbq	0x8c(%rsp), %rdi
               	movsbq	0x9c(%rsp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movb	%dl, 0x4c(%rsp)
               	movsbq	0x8d(%rsp), %rdi
               	movsbq	0x9d(%rsp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movb	%dl, 0x4d(%rsp)
               	movsbq	0x8e(%rsp), %rdi
               	movsbq	0x9e(%rsp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movb	%dl, 0x4e(%rsp)
               	movsbq	0x8f(%rsp), %rdi
               	movsbq	0x9f(%rsp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movb	%dl, 0x4f(%rsp)
               	leaq	0x160(%rsp), %rax
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movsbq	0x80(%rsp,%rcx), %rdi
               	movsbq	0x90(%rsp,%rcx), %r8
               	movl	%edi, %eax
               	cltd
               	idivl	%r8d
               	movb	%dl, -0x10(%rbp,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x160(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x80(%rsp), %xmm0
               	movups	0x90(%rsp), %xmm1
               	vpand	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movsbq	0x80(%rsp,%rax), %rdx
               	movsbq	0x90(%rsp,%rax), %rsi
               	andq	%rsi, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0xa0(%rsp), %xmm0
               	movups	0xb0(%rsp), %xmm1
               	vpaddw	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzwq	0xa0(%rsp,%rax,2), %rdx
               	movzwq	0xb0(%rsp,%rax,2), %rsi
               	addq	%rsi, %rdx
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, -0x10(%rbp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0xa0(%rsp), %xmm0
               	movups	0xb0(%rsp), %xmm1
               	vpsubw	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzwq	0xa0(%rsp,%rax,2), %rcx
               	movzwq	0xb0(%rsp,%rax,2), %rsi
               	subq	%rsi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, -0x10(%rbp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0xa0(%rsp), %xmm0
               	movups	0xb0(%rsp), %xmm1
               	vpmullw	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzwq	0xa0(%rsp,%rax,2), %rcx
               	movzwq	0xb0(%rsp,%rax,2), %rsi
               	imulq	%rsi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, -0x10(%rbp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movzwq	0xa0(%rsp), %rax
               	movzwq	0xb0(%rsp), %rcx
               	xorl	%edx, %edx
               	divl	%ecx
               	movq	%rax, %rcx
               	movzwq	0xa2(%rsp), %rax
               	movzwq	0xb2(%rsp), %rsi
               	xorl	%edx, %edx
               	divl	%esi
               	movq	%rax, %rsi
               	movzwq	0xa4(%rsp), %rax
               	movzwq	0xb4(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movq	%rax, %rdi
               	movzwq	0xa6(%rsp), %rax
               	movzwq	0xb6(%rsp), %r8
               	xorl	%edx, %edx
               	divl	%r8d
               	movq	%rax, %r8
               	movzwq	0xa8(%rsp), %rax
               	movzwq	0xb8(%rsp), %r9
               	xorl	%edx, %edx
               	divl	%r9d
               	movq	%rax, %r9
               	movzwq	0xaa(%rsp), %rax
               	movzwq	0xba(%rsp), %r10
               	xorl	%edx, %edx
               	divl	%r10d
               	movq	%rax, %r10
               	movzwq	0xac(%rsp), %rax
               	movzwq	0xbc(%rsp), %r11
               	xorl	%edx, %edx
               	divl	%r11d
               	movq	%rax, %r11
               	movzwq	0xae(%rsp), %rax
               	movzwq	0xbe(%rsp), %rdx
               	movq	%r10, -0x90(%rbp)
               	movq	%rdx, %r10
               	xorl	%edx, %edx
               	divl	%r10d
               	movw	%cx, 0x40(%rsp)
               	movw	%si, 0x42(%rsp)
               	movw	%di, 0x44(%rsp)
               	movw	%r8w, 0x46(%rsp)
               	movq	-0x90(%rbp), %r10
               	movw	%r9w, 0x48(%rsp)
               	movw	%r10w, 0x4a(%rsp)
               	movw	%r11w, 0x4c(%rsp)
               	movw	%ax, 0x4e(%rsp)
               	xorl	%ecx, %ecx
               	movzwq	0xa0(%rsp,%rcx,2), %rax
               	movzwq	0xb0(%rsp,%rcx,2), %rdi
               	cltd
               	idivl	%edi
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, -0x10(%rbp,%rcx,2)
               	incq	%rcx
               	nop
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movzwq	0xa0(%rsp), %rcx
               	movzwq	0xb0(%rsp), %rsi
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%esi
               	movq	%rdx, %rcx
               	movzwq	0xa2(%rsp), %rsi
               	movzwq	0xb2(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movq	%rdx, %rsi
               	movzwq	0xa4(%rsp), %rdi
               	movzwq	0xb4(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movq	%rdx, %rdi
               	movzwq	0xa6(%rsp), %r8
               	movzwq	0xb6(%rsp), %r9
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movq	%rdx, %r8
               	movzwq	0xa8(%rsp), %r9
               	movzwq	0xb8(%rsp), %r10
               	movl	%r9d, %eax
               	xorl	%edx, %edx
               	divl	%r10d
               	movq	%rdx, %r9
               	movzwq	0xaa(%rsp), %r10
               	movzwq	0xba(%rsp), %r11
               	movl	%r10d, %eax
               	xorl	%edx, %edx
               	divl	%r11d
               	movq	%rdx, %r10
               	movzwq	0xac(%rsp), %r11
               	movzwq	0xbc(%rsp), %rax
               	movq	%r10, -0x90(%rbp)
               	movq	%rax, %r10
               	movl	%r11d, %eax
               	xorl	%edx, %edx
               	divl	%r10d
               	movq	%rdx, %r11
               	movzwq	0xae(%rsp), %rax
               	movzwq	0xbe(%rsp), %rdx
               	movq	%rdx, %r10
               	xorl	%edx, %edx
               	divl	%r10d
               	movw	%cx, 0x40(%rsp)
               	movw	%si, 0x42(%rsp)
               	movw	%di, 0x44(%rsp)
               	movw	%r8w, 0x46(%rsp)
               	movq	-0x90(%rbp), %r10
               	movw	%r9w, 0x48(%rsp)
               	movw	%r10w, 0x4a(%rsp)
               	movw	%r11w, 0x4c(%rsp)
               	movw	%dx, 0x4e(%rsp)
               	xorl	%ecx, %ecx
               	movzwq	0xa0(%rsp,%rcx,2), %rdi
               	movzwq	0xb0(%rsp,%rcx,2), %r8
               	movl	%edi, %eax
               	cltd
               	idivl	%r8d
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, -0x10(%rbp,%rcx,2)
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	nop
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0xc0(%rsp), %xmm0
               	movups	0xd0(%rsp), %xmm1
               	vpaddw	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movswq	0xc0(%rsp,%rax,2), %rdx
               	movswq	0xd0(%rsp,%rax,2), %rsi
               	addq	%rsi, %rdx
               	movw	%dx, -0x10(%rbp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	nopl	(%rax,%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0xc0(%rsp), %xmm0
               	movups	0xd0(%rsp), %xmm1
               	vpsubw	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movswq	0xc0(%rsp,%rax,2), %rdx
               	movswq	0xd0(%rsp,%rax,2), %rsi
               	subq	%rsi, %rdx
               	movw	%dx, -0x10(%rbp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	nopl	(%rax,%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0xc0(%rsp), %xmm0
               	movups	0xd0(%rsp), %xmm1
               	vpmullw	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movswq	0xc0(%rsp,%rax,2), %rdx
               	movswq	0xd0(%rsp,%rax,2), %rsi
               	imulq	%rsi, %rdx
               	movw	%dx, -0x10(%rbp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movswq	0xc0(%rsp), %rax
               	movswq	0xd0(%rsp), %rcx
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	movswq	0xc2(%rsp), %rax
               	movswq	0xd2(%rsp), %rsi
               	cqto
               	idivq	%rsi
               	movq	%rax, %rsi
               	movswq	0xc4(%rsp), %rax
               	movswq	0xd4(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	movswq	0xc6(%rsp), %rax
               	movswq	0xd6(%rsp), %r8
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	movswq	0xc8(%rsp), %rax
               	movswq	0xd8(%rsp), %r9
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movswq	0xca(%rsp), %rax
               	movswq	0xda(%rsp), %r10
               	cqto
               	idivq	%r10
               	movq	%rax, %r10
               	movswq	0xcc(%rsp), %rax
               	movswq	0xdc(%rsp), %r11
               	cqto
               	idivq	%r11
               	movq	%rax, %r11
               	movswq	0xce(%rsp), %rax
               	movswq	0xde(%rsp), %rdx
               	movq	%r10, -0x90(%rbp)
               	movq	%rdx, %r10
               	cqto
               	idivq	%r10
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, 0x40(%rsp)
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movw	%si, 0x42(%rsp)
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movw	%di, 0x44(%rsp)
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	movw	%r8w, 0x46(%rsp)
               	movq	-0x90(%rbp), %r10
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movw	%r9w, 0x48(%rsp)
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movw	%r10w, 0x4a(%rsp)
               	andq	$0xffff, %r11           # imm = 0xFFFF
               	movw	%r11w, 0x4c(%rsp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x4e(%rsp)
               	xorl	%ecx, %ecx
               	movswq	0xc0(%rsp,%rcx,2), %rax
               	movswq	0xd0(%rsp,%rcx,2), %rdi
               	cltd
               	idivl	%edi
               	movw	%ax, -0x10(%rbp,%rcx,2)
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movswq	0xc0(%rsp), %rcx
               	movswq	0xd0(%rsp), %rsi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	movswq	0xc2(%rsp), %rsi
               	movswq	0xd2(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rsi
               	movswq	0xc4(%rsp), %rdi
               	movswq	0xd4(%rsp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rdx, %rdi
               	movswq	0xc6(%rsp), %r8
               	movswq	0xd6(%rsp), %r9
               	movq	%r8, %rax
               	cqto
               	idivq	%r9
               	movq	%rdx, %r8
               	movswq	0xc8(%rsp), %r9
               	movswq	0xd8(%rsp), %r10
               	movq	%r9, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %r9
               	movswq	0xca(%rsp), %r10
               	movswq	0xda(%rsp), %r11
               	movq	%r10, %rax
               	cqto
               	idivq	%r11
               	movq	%rdx, %r10
               	movswq	0xcc(%rsp), %r11
               	movswq	0xdc(%rsp), %rax
               	movq	%r10, -0x90(%rbp)
               	movq	%rax, %r10
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %r11
               	movswq	0xce(%rsp), %rax
               	movswq	0xde(%rsp), %rdx
               	movq	%rdx, %r10
               	cqto
               	idivq	%r10
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, 0x40(%rsp)
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movw	%si, 0x42(%rsp)
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movw	%di, 0x44(%rsp)
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	movw	%r8w, 0x46(%rsp)
               	movq	-0x90(%rbp), %r10
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movw	%r9w, 0x48(%rsp)
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movw	%r10w, 0x4a(%rsp)
               	andq	$0xffff, %r11           # imm = 0xFFFF
               	movw	%r11w, 0x4c(%rsp)
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, 0x4e(%rsp)
               	xorl	%ecx, %ecx
               	movswq	0xc0(%rsp,%rcx,2), %rdi
               	movswq	0xd0(%rsp,%rcx,2), %r8
               	movl	%edi, %eax
               	cltd
               	idivl	%r8d
               	movw	%dx, -0x10(%rbp,%rcx,2)
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0xe0(%rsp), %xmm0
               	movups	0xf0(%rsp), %xmm1
               	vpaddd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	0xf0(%rsp,%rax,4), %esi
               	addq	%rsi, %rdx
               	movl	%edx, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	nopl	(%rax,%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0xe0(%rsp), %xmm0
               	movups	0xf0(%rsp), %xmm1
               	vpsubd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	0xf0(%rsp,%rax,4), %esi
               	subq	%rsi, %rdx
               	movl	%edx, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	0xe0(%rsp), %eax
               	movl	0xf0(%rsp), %edx
               	imulq	%rdx, %rax
               	movl	0xe4(%rsp), %edx
               	movl	0xf4(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	0xe8(%rsp), %esi
               	movl	0xf8(%rsp), %edi
               	imulq	%rdi, %rsi
               	movl	0xec(%rsp), %edi
               	movl	0xfc(%rsp), %r10d
               	imulq	%r10, %rdi
               	movl	%eax, 0x40(%rsp)
               	movl	%edx, 0x44(%rsp)
               	movl	%esi, 0x48(%rsp)
               	movl	%edi, 0x4c(%rsp)
               	xorl	%eax, %eax
               	movl	0xe0(%rsp,%rax,4), %edx
               	movl	0xf0(%rsp,%rax,4), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, -0x10(%rbp,%rax,4)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdx
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	0xe0(%rsp), %eax
               	movl	0xf0(%rsp), %ecx
               	xorl	%edx, %edx
               	divl	%ecx
               	movq	%rax, %rcx
               	movl	0xe4(%rsp), %eax
               	movl	0xf4(%rsp), %edi
               	xorl	%edx, %edx
               	divl	%edi
               	movq	%rax, %rdi
               	movl	0xe8(%rsp), %eax
               	movl	0xf8(%rsp), %r10d
               	xorl	%edx, %edx
               	divl	%r10d
               	movq	%rax, %r10
               	movl	0xec(%rsp), %eax
               	movl	0xfc(%rsp), %r11d
               	xorl	%edx, %edx
               	divl	%r11d
               	movl	%ecx, 0x40(%rsp)
               	movl	%edi, 0x44(%rsp)
               	movl	%r10d, 0x48(%rsp)
               	movl	%eax, 0x4c(%rsp)
               	xorl	%ecx, %ecx
               	movl	0xe0(%rsp,%rcx,4), %eax
               	movl	0xf0(%rsp,%rcx,4), %edi
               	xorl	%edx, %edx
               	divl	%edi
               	movl	%eax, -0x10(%rbp,%rcx,4)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdx
               	movzbq	-0x10(%rbp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	0xe0(%rsp), %ecx
               	movl	0xf0(%rsp), %edi
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movq	%rdx, %rcx
               	movl	0xe4(%rsp), %edi
               	movl	0xf4(%rsp), %r8d
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movq	%rdx, %rdi
               	movl	0xe8(%rsp), %r8d
               	movl	0xf8(%rsp), %r11d
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%r11d
               	movq	%rdx, %r8
               	movl	0xec(%rsp), %r11d
               	movl	0xfc(%rsp), %eax
               	movq	%r10, -0x90(%rbp)
               	movq	%rax, %r10
               	movl	%r11d, %eax
               	xorl	%edx, %edx
               	divl	%r10d
               	movq	-0x90(%rbp), %r10
               	movl	%ecx, 0x40(%rsp)
               	movl	%edi, 0x44(%rsp)
               	movl	%r8d, 0x48(%rsp)
               	movl	%edx, 0x4c(%rsp)
               	xorl	%ecx, %ecx
               	movl	0xe0(%rsp,%rcx,4), %edi
               	movl	0xf0(%rsp,%rcx,4), %r8d
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movl	%edx, -0x10(%rbp,%rcx,4)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x100(%rsp), %xmm0
               	movups	0x110(%rsp), %xmm1
               	vpaddd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movl	0x100(%rsp,%rax,4), %edx
               	movl	0x110(%rsp,%rax,4), %esi
               	addq	%rsi, %rdx
               	movl	%edx, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x100(%rsp), %xmm0
               	movups	0x110(%rsp), %xmm1
               	vpsubd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movl	0x100(%rsp,%rax,4), %edx
               	movl	0x110(%rsp,%rax,4), %esi
               	subq	%rsi, %rdx
               	movl	%edx, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	0x100(%rsp), %eax
               	movl	0x110(%rsp), %edx
               	imulq	%rdx, %rax
               	movl	0x104(%rsp), %edx
               	movl	0x114(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	0x108(%rsp), %esi
               	movl	0x118(%rsp), %edi
               	imulq	%rdi, %rsi
               	movl	0x10c(%rsp), %edi
               	movl	0x11c(%rsp), %r10d
               	imulq	%r10, %rdi
               	movl	%eax, 0x40(%rsp)
               	movl	%edx, 0x44(%rsp)
               	movl	%esi, 0x48(%rsp)
               	movl	%edi, 0x4c(%rsp)
               	xorl	%eax, %eax
               	movl	0x100(%rsp,%rax,4), %edx
               	movl	0x110(%rsp,%rax,4), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, -0x10(%rbp,%rax,4)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdx
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movslq	0x100(%rsp), %rax
               	movslq	0x110(%rsp), %rcx
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	movslq	0x104(%rsp), %rax
               	movslq	0x114(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	movslq	0x108(%rsp), %rax
               	movslq	0x118(%rsp), %r10
               	cqto
               	idivq	%r10
               	movq	%rax, %r10
               	movslq	0x10c(%rsp), %rax
               	movslq	0x11c(%rsp), %r11
               	cqto
               	idivq	%r11
               	movl	%ecx, 0x40(%rsp)
               	movl	%edi, 0x44(%rsp)
               	movl	%r10d, 0x48(%rsp)
               	movl	%eax, 0x4c(%rsp)
               	xorl	%ecx, %ecx
               	movl	0x100(%rsp,%rcx,4), %eax
               	movl	0x110(%rsp,%rcx,4), %edi
               	cltd
               	idivl	%edi
               	movl	%eax, -0x10(%rbp,%rcx,4)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdx
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movslq	0x100(%rsp), %rcx
               	movslq	0x110(%rsp), %rdi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rcx
               	movslq	0x104(%rsp), %rdi
               	movslq	0x114(%rsp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rdx, %rdi
               	movslq	0x108(%rsp), %r8
               	movslq	0x118(%rsp), %r11
               	movq	%r8, %rax
               	cqto
               	idivq	%r11
               	movq	%rdx, %r8
               	movslq	0x10c(%rsp), %r11
               	movslq	0x11c(%rsp), %rax
               	movq	%r10, -0x90(%rbp)
               	movq	%rax, %r10
               	movq	%r11, %rax
               	cqto
               	idivq	%r10
               	movq	-0x90(%rbp), %r10
               	movl	%ecx, 0x40(%rsp)
               	movl	%edi, 0x44(%rsp)
               	movl	%r8d, 0x48(%rsp)
               	movl	%edx, 0x4c(%rsp)
               	xorl	%ecx, %ecx
               	movl	0x100(%rsp,%rcx,4), %edi
               	movl	0x110(%rsp,%rcx,4), %r8d
               	movl	%edi, %eax
               	cltd
               	idivl	%r8d
               	movl	%edx, -0x10(%rbp,%rcx,4)
               	incq	%rcx
               	nopl	(%rax)
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x120(%rsp), %xmm0
               	movups	0x130(%rsp), %xmm1
               	vpaddq	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movq	0x120(%rsp,%rax,8), %rdx
               	movq	0x130(%rsp,%rax,8), %rsi
               	addq	%rsi, %rdx
               	movq	%rdx, -0x10(%rbp,%rax,8)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x120(%rsp), %xmm0
               	movups	0x130(%rsp), %xmm1
               	vpsubq	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movq	0x120(%rsp,%rax,8), %rdx
               	movq	0x130(%rsp,%rax,8), %rsi
               	subq	%rsi, %rdx
               	movq	%rdx, -0x10(%rbp,%rax,8)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	0x120(%rsp), %rax
               	movq	0x130(%rsp), %rdx
               	imulq	%rdx, %rax
               	movq	0x128(%rsp), %rdx
               	movq	0x138(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	%rdx, 0x48(%rsp)
               	xorl	%eax, %eax
               	movq	0x120(%rsp,%rax,8), %rdx
               	movq	0x130(%rsp,%rax,8), %rsi
               	imulq	%rsi, %rdx
               	movq	%rdx, -0x10(%rbp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdx
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	0x120(%rsp), %rax
               	movq	0x130(%rsp), %rcx
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rax, %rcx
               	movq	0x128(%rsp), %rax
               	movq	0x138(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rcx, 0x40(%rsp)
               	movq	%rax, 0x48(%rsp)
               	xorl	%ecx, %ecx
               	movq	0x120(%rsp,%rcx,8), %rax
               	movq	0x130(%rsp,%rcx,8), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rax, -0x10(%rbp,%rcx,8)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdx
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	0x120(%rsp), %rcx
               	movq	0x130(%rsp), %rdi
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rdx, %rcx
               	movq	0x128(%rsp), %rdi
               	movq	0x138(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rcx, 0x40(%rsp)
               	movq	%rdx, 0x48(%rsp)
               	xorl	%ecx, %ecx
               	movq	0x120(%rsp,%rcx,8), %rdi
               	movq	0x130(%rsp,%rcx,8), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rdx, -0x10(%rbp,%rcx,8)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x140(%rsp), %xmm0
               	movups	0x150(%rsp), %xmm1
               	vpaddq	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movq	0x140(%rsp,%rax,8), %rdx
               	movq	0x150(%rsp,%rax,8), %rsi
               	addq	%rsi, %rdx
               	movq	%rdx, -0x10(%rbp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x140(%rsp), %xmm0
               	movups	0x150(%rsp), %xmm1
               	vpsubq	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movq	0x140(%rsp,%rax,8), %rdx
               	movq	0x150(%rsp,%rax,8), %rsi
               	subq	%rsi, %rdx
               	movq	%rdx, -0x10(%rbp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	0x140(%rsp), %rax
               	movq	0x150(%rsp), %rdx
               	imulq	%rdx, %rax
               	movq	0x148(%rsp), %rdx
               	movq	0x158(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	%rdx, 0x48(%rsp)
               	xorl	%eax, %eax
               	movq	0x140(%rsp,%rax,8), %rdx
               	movq	0x150(%rsp,%rax,8), %rsi
               	imulq	%rsi, %rdx
               	movq	%rdx, -0x10(%rbp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdx
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	0x140(%rsp), %rax
               	movq	0x150(%rsp), %rcx
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	movq	0x148(%rsp), %rax
               	movq	0x158(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movq	%rcx, 0x40(%rsp)
               	movq	%rax, 0x48(%rsp)
               	xorl	%ecx, %ecx
               	movq	0x140(%rsp,%rcx,8), %rax
               	movq	0x150(%rsp,%rcx,8), %rdi
               	cqto
               	idivq	%rdi
               	movq	%rax, -0x10(%rbp,%rcx,8)
               	incq	%rcx
               	nopl	(%rax,%rax)
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdx
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	0x140(%rsp), %rcx
               	movq	0x150(%rsp), %rdi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rcx
               	movq	0x148(%rsp), %rdi
               	movq	0x158(%rsp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rcx, 0x40(%rsp)
               	movq	%rdx, 0x48(%rsp)
               	xorl	%ecx, %ecx
               	movq	0x140(%rsp,%rcx,8), %rdi
               	movq	0x150(%rsp,%rcx,8), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rdx, -0x10(%rbp,%rcx,8)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movsd	-0x38(%rbp), %xmm0
               	movsd	-0x30(%rbp), %xmm1
               	vpaddb	%xmm1, %xmm0, %xmm0
               	movsd	%xmm0, -0x28(%rbp)
               	xorl	%eax, %eax
               	movzbq	-0x38(%rbp,%rax), %rcx
               	movzbq	-0x30(%rbp,%rax), %rsi
               	addq	%rsi, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x8(%rbp,%rax)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x28(%rbp,%rax), %rsi
               	movzbq	-0x8(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movzbq	-0x38(%rbp), %rax
               	movzbq	-0x30(%rbp), %rcx
               	imulq	%rcx, %rax
               	movzbq	-0x37(%rbp), %rcx
               	movzbq	-0x2f(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movzbq	-0x36(%rbp), %rdx
               	movzbq	-0x2e(%rbp), %rsi
               	imulq	%rsi, %rdx
               	movzbq	-0x35(%rbp), %rsi
               	movzbq	-0x2d(%rbp), %rdi
               	imulq	%rdi, %rsi
               	movzbq	-0x34(%rbp), %rdi
               	movzbq	-0x2c(%rbp), %r8
               	imulq	%r8, %rdi
               	movzbq	-0x33(%rbp), %r8
               	movzbq	-0x2b(%rbp), %r9
               	imulq	%r9, %r8
               	movzbq	-0x32(%rbp), %r9
               	movzbq	-0x2a(%rbp), %r10
               	imulq	%r10, %r9
               	movzbq	-0x31(%rbp), %r10
               	movzbq	-0x29(%rbp), %r11
               	imulq	%r11, %r10
               	andq	$0xff, %rax
               	movb	%al, -0x28(%rbp)
               	andq	$0xff, %rcx
               	movb	%cl, -0x27(%rbp)
               	andq	$0xff, %rdx
               	movb	%dl, -0x26(%rbp)
               	andq	$0xff, %rsi
               	movb	%sil, -0x25(%rbp)
               	andq	$0xff, %rdi
               	movb	%dil, -0x24(%rbp)
               	andq	$0xff, %r8
               	movb	%r8b, -0x23(%rbp)
               	andq	$0xff, %r9
               	movb	%r9b, -0x22(%rbp)
               	andq	$0xff, %r10
               	movb	%r10b, -0x21(%rbp)
               	xorl	%eax, %eax
               	movzbq	-0x38(%rbp,%rax), %rcx
               	movzbq	-0x30(%rbp,%rax), %rsi
               	imulq	%rsi, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x8(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	-0x28(%rbp,%rax), %rsi
               	movzbq	-0x8(%rbp,%rax), %rdi
               	nop
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vpaddd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movl	(%rsp,%rax,4), %edx
               	movl	0x20(%rsp,%rax,4), %esi
               	addq	%rsi, %rdx
               	movl	%edx, -0x20(%rbp,%rax,4)
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x20(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x20, %eax
               	jl	<addr>
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vpsubd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movl	(%rsp,%rax,4), %edx
               	movl	0x20(%rsp,%rax,4), %esi
               	subq	%rsi, %rdx
               	movl	%edx, -0x20(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x20(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	0x160(%rsp), %rdx
               	leaq	<rip>, %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rdx)
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	0x40(%rsp), %rcx
               	movzbq	0x60(%rsp), %rax
               	movb	%al, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rax
               	shlq	%rax
               	movb	%al, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rax
               	shlq	$0x2, %rax
               	movb	%al, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rax
               	shlq	$0x4, %rax
               	movb	%al, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rax
               	shlq	$0x5, %rax
               	movb	%al, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rax
               	shlq	$0x6, %rax
               	movb	%al, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rax
               	shlq	$0x7, %rax
               	movb	%al, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rax
               	movb	%al, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rax
               	shlq	%rax
               	movb	%al, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rax
               	shlq	$0x2, %rax
               	movb	%al, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rax
               	shlq	$0x3, %rax
               	movb	%al, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rax
               	shlq	$0x4, %rax
               	movb	%al, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rax
               	shlq	$0x5, %rax
               	movb	%al, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rax
               	shlq	$0x6, %rax
               	movb	%al, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rax
               	shlq	$0x7, %rax
               	movb	%al, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rcx
               	movzbq	0x160(%rsp,%rax), %rdi
               	shlxq	%rdi, %rcx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rax
               	movzbq	0x60(%rsp), %rdx
               	movzbq	0x160(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	movzbq	0x161(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	movzbq	0x162(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	movzbq	0x163(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	movzbq	0x164(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	movzbq	0x165(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	movzbq	0x166(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	movzbq	0x167(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	movzbq	0x168(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	movzbq	0x169(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	movzbq	0x16a(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	movzbq	0x16b(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	movzbq	0x16c(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	movzbq	0x16d(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	movzbq	0x16e(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	movzbq	0x16f(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rdx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rdx
               	movzbq	0x160(%rsp,%rax), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movswq	0xc0(%rsp), %rax
               	movswq	(%rsp), %rcx
               	sarxq	%rcx, %rax, %rax
               	movswq	0xc2(%rsp), %rcx
               	movswq	0x2(%rsp), %rdx
               	sarxq	%rdx, %rcx, %rcx
               	movswq	0xc4(%rsp), %rdx
               	movswq	0x4(%rsp), %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movswq	0xc6(%rsp), %rsi
               	movswq	0x6(%rsp), %rdi
               	sarxq	%rdi, %rsi, %rsi
               	movswq	0xc8(%rsp), %rdi
               	movswq	0x8(%rsp), %r8
               	sarxq	%r8, %rdi, %rdi
               	movswq	0xca(%rsp), %r8
               	movswq	0xa(%rsp), %r9
               	sarxq	%r9, %r8, %r8
               	movswq	0xcc(%rsp), %r9
               	movswq	0xc(%rsp), %r10
               	sarxq	%r10, %r9, %r9
               	movswq	0xce(%rsp), %r10
               	movswq	0xe(%rsp), %r11
               	sarxq	%r11, %r10, %r10
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x40(%rsp)
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, 0x42(%rsp)
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, 0x44(%rsp)
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movw	%si, 0x46(%rsp)
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movw	%di, 0x48(%rsp)
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	movw	%r8w, 0x4a(%rsp)
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movw	%r9w, 0x4c(%rsp)
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movw	%r10w, 0x4e(%rsp)
               	xorl	%eax, %eax
               	movswq	0xc0(%rsp,%rax,2), %rdx
               	movswq	(%rsp,%rax,2), %rsi
               	sarxq	%rsi, %rdx, %rdx
               	movw	%dx, -0x10(%rbp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movswq	0xc0(%rsp), %rax
               	movswq	(%rsp), %rcx
               	shlxq	%rcx, %rax, %rax
               	movswq	0xc2(%rsp), %rcx
               	movswq	0x2(%rsp), %rdx
               	shlxq	%rdx, %rcx, %rcx
               	movswq	0xc4(%rsp), %rdx
               	movswq	0x4(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movswq	0xc6(%rsp), %rsi
               	movswq	0x6(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movswq	0xc8(%rsp), %rdi
               	movswq	0x8(%rsp), %r8
               	shlxq	%r8, %rdi, %rdi
               	movswq	0xca(%rsp), %r8
               	movswq	0xa(%rsp), %r9
               	shlxq	%r9, %r8, %r8
               	movswq	0xcc(%rsp), %r9
               	movswq	0xc(%rsp), %r10
               	shlxq	%r10, %r9, %r9
               	movswq	0xce(%rsp), %r10
               	movswq	0xe(%rsp), %r11
               	shlxq	%r11, %r10, %r10
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x40(%rsp)
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, 0x42(%rsp)
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, 0x44(%rsp)
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movw	%si, 0x46(%rsp)
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movw	%di, 0x48(%rsp)
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	movw	%r8w, 0x4a(%rsp)
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movw	%r9w, 0x4c(%rsp)
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movw	%r10w, 0x4e(%rsp)
               	xorl	%eax, %eax
               	movswq	0xc0(%rsp,%rax,2), %rdx
               	movswq	(%rsp,%rax,2), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movw	%dx, -0x10(%rbp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x100(%rsp), %xmm0
               	psrad	$0x3, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movslq	0x100(%rsp,%rax,4), %rdx
               	sarq	$0x3, %rdx
               	movl	%edx, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0xe0(%rsp), %xmm0
               	psrld	$0x3, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movl	0xe0(%rsp,%rax,4), %edx
               	shrq	$0x3, %rdx
               	movl	%edx, -0x10(%rbp,%rax,4)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rdx
               	movsbq	0x80(%rsp), %rax
               	shlq	$0x2, %rax
               	movb	%al, 0x40(%rsp)
               	movsbq	0x81(%rsp), %rax
               	shlq	$0x2, %rax
               	movb	%al, 0x41(%rsp)
               	movsbq	0x82(%rsp), %rax
               	shlq	$0x2, %rax
               	movb	%al, 0x42(%rsp)
               	movsbq	0x83(%rsp), %rax
               	shlq	$0x2, %rax
               	movb	%al, 0x43(%rsp)
               	movsbq	0x84(%rsp), %rax
               	shlq	$0x2, %rax
               	movb	%al, 0x44(%rsp)
               	movsbq	0x85(%rsp), %rax
               	shlq	$0x2, %rax
               	movb	%al, 0x45(%rsp)
               	movsbq	0x86(%rsp), %rax
               	shlq	$0x2, %rax
               	movb	%al, 0x46(%rsp)
               	movsbq	0x87(%rsp), %rax
               	shlq	$0x2, %rax
               	movb	%al, 0x47(%rsp)
               	movsbq	0x88(%rsp), %rax
               	shlq	$0x2, %rax
               	movb	%al, 0x48(%rsp)
               	movsbq	0x89(%rsp), %rax
               	shlq	$0x2, %rax
               	movb	%al, 0x49(%rsp)
               	movsbq	0x8a(%rsp), %rax
               	shlq	$0x2, %rax
               	movb	%al, 0x4a(%rsp)
               	movsbq	0x8b(%rsp), %rax
               	shlq	$0x2, %rax
               	movb	%al, 0x4b(%rsp)
               	movsbq	0x8c(%rsp), %rax
               	shlq	$0x2, %rax
               	movb	%al, 0x4c(%rsp)
               	movsbq	0x8d(%rsp), %rax
               	shlq	$0x2, %rax
               	movb	%al, 0x4d(%rsp)
               	movsbq	0x8e(%rsp), %rax
               	shlq	$0x2, %rax
               	movb	%al, 0x4e(%rsp)
               	movsbq	0x8f(%rsp), %rax
               	shlq	$0x2, %rax
               	movb	%al, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rdx), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movsbq	0x80(%rsp,%rax), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rax
               	movzbq	0x60(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rdx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rdx
               	subq	$0x40, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	nop
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rax
               	movzbq	0x60(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rdx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rdx
               	addq	$0x64, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	nop
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x7, %eax
               	leaq	0x40(%rsp), %rdi
               	movzbq	0x60(%rsp), %rdx
               	imulq	%rax, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	imulq	%rax, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	imulq	%rax, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	imulq	%rax, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	imulq	%rax, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	imulq	%rax, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	imulq	%rax, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	imulq	%rax, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	imulq	%rax, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	imulq	%rax, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	imulq	%rax, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	imulq	%rax, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	imulq	%rax, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	imulq	%rax, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	imulq	%rax, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	imulq	%rax, %rdx
               	movb	%dl, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rdi), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rdx
               	imulq	$0x7, %rdx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rdx
               	movzbq	0x60(%rsp), %rax
               	imulq	$0x24924925, %rax, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movb	%al, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rax
               	imulq	$0x24924925, %rax, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movb	%al, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rax
               	imulq	$0x24924925, %rax, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movb	%al, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rax
               	imulq	$0x24924925, %rax, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movb	%al, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rax
               	imulq	$0x24924925, %rax, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movb	%al, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rax
               	imulq	$0x24924925, %rax, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movb	%al, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rax
               	imulq	$0x24924925, %rax, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movb	%al, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rax
               	imulq	$0x24924925, %rax, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movb	%al, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rax
               	imulq	$0x24924925, %rax, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movb	%al, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rax
               	imulq	$0x24924925, %rax, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movb	%al, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rax
               	imulq	$0x24924925, %rax, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movb	%al, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rax
               	imulq	$0x24924925, %rax, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movb	%al, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rax
               	imulq	$0x24924925, %rax, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movb	%al, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rax
               	imulq	$0x24924925, %rax, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movb	%al, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rax
               	imulq	$0x24924925, %rax, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movb	%al, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rax
               	imulq	$0x24924925, %rax, %rax # imm = 0x24924925
               	shrq	$0x20, %rax
               	movb	%al, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rdx), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rsi
               	movzbq	0x60(%rsp), %rax
               	imulq	$0x24924925, %rax, %rcx # imm = 0x24924925
               	shrq	$0x20, %rcx
               	imulq	$0x7, %rcx, %rcx
               	subq	%rcx, %rax
               	movb	%al, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rax
               	imulq	$0x24924925, %rax, %rcx # imm = 0x24924925
               	shrq	$0x20, %rcx
               	imulq	$0x7, %rcx, %rcx
               	subq	%rcx, %rax
               	movb	%al, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rax
               	imulq	$0x24924925, %rax, %rcx # imm = 0x24924925
               	shrq	$0x20, %rcx
               	imulq	$0x7, %rcx, %rcx
               	subq	%rcx, %rax
               	movb	%al, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rax
               	imulq	$0x24924925, %rax, %rcx # imm = 0x24924925
               	shrq	$0x20, %rcx
               	imulq	$0x7, %rcx, %rcx
               	subq	%rcx, %rax
               	movb	%al, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rax
               	imulq	$0x24924925, %rax, %rcx # imm = 0x24924925
               	shrq	$0x20, %rcx
               	imulq	$0x7, %rcx, %rcx
               	subq	%rcx, %rax
               	movb	%al, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rax
               	imulq	$0x24924925, %rax, %rcx # imm = 0x24924925
               	shrq	$0x20, %rcx
               	imulq	$0x7, %rcx, %rcx
               	subq	%rcx, %rax
               	movb	%al, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rax
               	imulq	$0x24924925, %rax, %rcx # imm = 0x24924925
               	shrq	$0x20, %rcx
               	imulq	$0x7, %rcx, %rcx
               	subq	%rcx, %rax
               	movb	%al, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rax
               	imulq	$0x24924925, %rax, %rcx # imm = 0x24924925
               	shrq	$0x20, %rcx
               	imulq	$0x7, %rcx, %rcx
               	subq	%rcx, %rax
               	movb	%al, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rax
               	imulq	$0x24924925, %rax, %rcx # imm = 0x24924925
               	shrq	$0x20, %rcx
               	imulq	$0x7, %rcx, %rcx
               	subq	%rcx, %rax
               	movb	%al, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rax
               	imulq	$0x24924925, %rax, %rcx # imm = 0x24924925
               	shrq	$0x20, %rcx
               	imulq	$0x7, %rcx, %rcx
               	subq	%rcx, %rax
               	movb	%al, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rax
               	imulq	$0x24924925, %rax, %rcx # imm = 0x24924925
               	shrq	$0x20, %rcx
               	imulq	$0x7, %rcx, %rcx
               	subq	%rcx, %rax
               	movb	%al, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rax
               	imulq	$0x24924925, %rax, %rcx # imm = 0x24924925
               	shrq	$0x20, %rcx
               	imulq	$0x7, %rcx, %rcx
               	subq	%rcx, %rax
               	movb	%al, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rax
               	imulq	$0x24924925, %rax, %rcx # imm = 0x24924925
               	shrq	$0x20, %rcx
               	imulq	$0x7, %rcx, %rcx
               	subq	%rcx, %rax
               	movb	%al, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rax
               	imulq	$0x24924925, %rax, %rcx # imm = 0x24924925
               	shrq	$0x20, %rcx
               	imulq	$0x7, %rcx, %rcx
               	subq	%rcx, %rax
               	movb	%al, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rax
               	imulq	$0x24924925, %rax, %rcx # imm = 0x24924925
               	shrq	$0x20, %rcx
               	imulq	$0x7, %rcx, %rcx
               	subq	%rcx, %rax
               	movb	%al, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rax
               	imulq	$0x24924925, %rax, %rcx # imm = 0x24924925
               	shrq	$0x20, %rcx
               	imulq	$0x7, %rcx, %rcx
               	subq	%rcx, %rax
               	movb	%al, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rsi), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rcx
               	imulq	$0x24924925, %rcx, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rcx
               	movb	%cl, -0x10(%rbp,%rax)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0xf, %eax
               	leaq	0x40(%rsp), %rdi
               	movzbq	0x60(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rdi), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rdx
               	andq	$0xf, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0xf0, %eax
               	leaq	0x40(%rsp), %rdi
               	movzbq	0x60(%rsp), %rdx
               	orq	%rax, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	orq	%rax, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	orq	%rax, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	orq	%rax, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	orq	%rax, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	orq	%rax, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	orq	%rax, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	orq	%rax, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	orq	%rax, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	orq	%rax, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	orq	%rax, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	orq	%rax, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	orq	%rax, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	orq	%rax, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	orq	%rax, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	orq	%rax, %rdx
               	movb	%dl, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rdi), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rdx
               	orq	$0xf0, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x55, %eax
               	leaq	0x40(%rsp), %rdi
               	movzbq	0x60(%rsp), %rdx
               	xorq	%rax, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	xorq	%rax, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	xorq	%rax, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	xorq	%rax, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	xorq	%rax, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	xorq	%rax, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	xorq	%rax, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	xorq	%rax, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	xorq	%rax, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	xorq	%rax, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	xorq	%rax, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	xorq	%rax, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	xorq	%rax, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	xorq	%rax, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	xorq	%rax, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	xorq	%rax, %rdx
               	movb	%dl, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rdi), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rdx
               	xorq	$0x55, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rax
               	movsbq	0x80(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x40(%rsp)
               	movsbq	0x81(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x41(%rsp)
               	movsbq	0x82(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x42(%rsp)
               	movsbq	0x83(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x43(%rsp)
               	movsbq	0x84(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x44(%rsp)
               	movsbq	0x85(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x45(%rsp)
               	movsbq	0x86(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x46(%rsp)
               	movsbq	0x87(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x47(%rsp)
               	movsbq	0x88(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x48(%rsp)
               	movsbq	0x89(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x49(%rsp)
               	movsbq	0x8a(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movsbq	0x8b(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movsbq	0x8c(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movsbq	0x8d(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movsbq	0x8e(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movsbq	0x8f(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rdx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movsbq	0x80(%rsp,%rax), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	movsbq	0x80(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x40(%rsp)
               	movsbq	0x81(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x41(%rsp)
               	movsbq	0x82(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x42(%rsp)
               	movsbq	0x83(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x43(%rsp)
               	movsbq	0x84(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x44(%rsp)
               	movsbq	0x85(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x45(%rsp)
               	movsbq	0x86(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x46(%rsp)
               	movsbq	0x87(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x47(%rsp)
               	movsbq	0x88(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x48(%rsp)
               	movsbq	0x89(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x49(%rsp)
               	movsbq	0x8a(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x4a(%rsp)
               	movsbq	0x8b(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x4b(%rsp)
               	movsbq	0x8c(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x4c(%rsp)
               	movsbq	0x8d(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x4d(%rsp)
               	movsbq	0x8e(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x4e(%rsp)
               	movsbq	0x8f(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movsbq	0x80(%rsp,%rax), %rcx
               	imulq	$0x55555556, %rcx, %rcx # imm = 0x55555556
               	sarq	$0x20, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rcx
               	movb	%cl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rdx
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rdx
               	movsbq	0x80(%rsp), %rcx
               	imulq	$0x55555556, %rcx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rax
               	subq	%rax, %rcx
               	movb	%cl, 0x40(%rsp)
               	movsbq	0x81(%rsp), %rcx
               	imulq	$0x55555556, %rcx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rax
               	subq	%rax, %rcx
               	movb	%cl, 0x41(%rsp)
               	movsbq	0x82(%rsp), %rcx
               	imulq	$0x55555556, %rcx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rax
               	subq	%rax, %rcx
               	movb	%cl, 0x42(%rsp)
               	movsbq	0x83(%rsp), %rcx
               	imulq	$0x55555556, %rcx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rax
               	subq	%rax, %rcx
               	movb	%cl, 0x43(%rsp)
               	movsbq	0x84(%rsp), %rcx
               	imulq	$0x55555556, %rcx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rax
               	subq	%rax, %rcx
               	movb	%cl, 0x44(%rsp)
               	movsbq	0x85(%rsp), %rcx
               	imulq	$0x55555556, %rcx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rax
               	subq	%rax, %rcx
               	movb	%cl, 0x45(%rsp)
               	movsbq	0x86(%rsp), %rcx
               	imulq	$0x55555556, %rcx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rax
               	subq	%rax, %rcx
               	movb	%cl, 0x46(%rsp)
               	movsbq	0x87(%rsp), %rcx
               	imulq	$0x55555556, %rcx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rax
               	subq	%rax, %rcx
               	movb	%cl, 0x47(%rsp)
               	movsbq	0x88(%rsp), %rcx
               	imulq	$0x55555556, %rcx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rax
               	subq	%rax, %rcx
               	movb	%cl, 0x48(%rsp)
               	movsbq	0x89(%rsp), %rcx
               	imulq	$0x55555556, %rcx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rax
               	subq	%rax, %rcx
               	movb	%cl, 0x49(%rsp)
               	movsbq	0x8a(%rsp), %rcx
               	imulq	$0x55555556, %rcx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rax
               	subq	%rax, %rcx
               	movb	%cl, 0x4a(%rsp)
               	movsbq	0x8b(%rsp), %rcx
               	imulq	$0x55555556, %rcx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rax
               	subq	%rax, %rcx
               	movb	%cl, 0x4b(%rsp)
               	movsbq	0x8c(%rsp), %rcx
               	imulq	$0x55555556, %rcx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rax
               	subq	%rax, %rcx
               	movb	%cl, 0x4c(%rsp)
               	movsbq	0x8d(%rsp), %rcx
               	imulq	$0x55555556, %rcx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rax
               	subq	%rax, %rcx
               	movb	%cl, 0x4d(%rsp)
               	movsbq	0x8e(%rsp), %rcx
               	imulq	$0x55555556, %rcx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rax
               	subq	%rax, %rcx
               	movb	%cl, 0x4e(%rsp)
               	movsbq	0x8f(%rsp), %rcx
               	imulq	$0x55555556, %rcx, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rax
               	leaq	(%rax,%rax,2), %rax
               	subq	%rax, %rcx
               	movb	%cl, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rdx), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movsbq	0x80(%rsp,%rax), %rdx
               	imulq	$0x55555556, %rdx, %rcx # imm = 0x55555556
               	sarq	$0x20, %rcx
               	movq	%rcx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	subq	%rcx, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	movzwq	0xa0(%rsp), %rcx
               	imulq	%rax, %rcx
               	movzwq	0xa2(%rsp), %rdx
               	imulq	%rax, %rdx
               	movzwq	0xa4(%rsp), %rsi
               	imulq	%rax, %rsi
               	movzwq	0xa6(%rsp), %rdi
               	imulq	%rax, %rdi
               	movzwq	0xa8(%rsp), %r8
               	imulq	%rax, %r8
               	movzwq	0xaa(%rsp), %r9
               	imulq	%rax, %r9
               	movzwq	0xac(%rsp), %r10
               	imulq	%rax, %r10
               	movzwq	0xae(%rsp), %r11
               	imulq	%rax, %r11
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, 0x40(%rsp)
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, 0x42(%rsp)
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movw	%si, 0x44(%rsp)
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movw	%di, 0x46(%rsp)
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	movw	%r8w, 0x48(%rsp)
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movw	%r9w, 0x4a(%rsp)
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movw	%r10w, 0x4c(%rsp)
               	andq	$0xffff, %r11           # imm = 0xFFFF
               	movw	%r11w, 0x4e(%rsp)
               	xorl	%eax, %eax
               	movzwq	0xa0(%rsp,%rax,2), %rcx
               	imulq	$0x3e8, %rcx, %rcx      # imm = 0x3E8
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, -0x10(%rbp,%rax,2)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x7, %eax
               	movq	0x140(%rsp), %rdx
               	imulq	%rax, %rdx
               	movq	0x148(%rsp), %rsi
               	imulq	%rax, %rsi
               	movq	%rdx, 0x40(%rsp)
               	movq	%rsi, 0x48(%rsp)
               	xorl	%eax, %eax
               	movq	0x140(%rsp,%rax,8), %rdx
               	imulq	$0x7, %rdx, %rdx
               	movq	%rdx, -0x10(%rbp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x40, %eax
               	leaq	0x40(%rsp), %rcx
               	movzbq	0x60(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movl	$0x40, %ecx
               	movzbq	0x60(%rsp,%rax), %rsi
               	subq	%rsi, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x64, %eax
               	leaq	0x40(%rsp), %rdx
               	movsbq	0x80(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x40(%rsp)
               	movsbq	0x81(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x41(%rsp)
               	movsbq	0x82(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x42(%rsp)
               	movsbq	0x83(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x43(%rsp)
               	movsbq	0x84(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x44(%rsp)
               	movsbq	0x85(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x45(%rsp)
               	movsbq	0x86(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x46(%rsp)
               	movsbq	0x87(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x47(%rsp)
               	movsbq	0x88(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x48(%rsp)
               	movsbq	0x89(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x49(%rsp)
               	movsbq	0x8a(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x4a(%rsp)
               	movsbq	0x8b(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x4b(%rsp)
               	movsbq	0x8c(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x4c(%rsp)
               	movsbq	0x8d(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x4d(%rsp)
               	movsbq	0x8e(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x4e(%rsp)
               	movsbq	0x8f(%rsp), %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rdx), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movl	$0x64, %edx
               	movsbq	0x80(%rsp,%rax), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rdx
               	movzbq	-0x10(%rbp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0xfa, %ecx
               	leaq	0x40(%rsp), %rdi
               	movzbq	0x70(%rsp), %r9
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%al, 0x40(%rsp)
               	movzbq	0x71(%rsp), %r9
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%al, 0x41(%rsp)
               	movzbq	0x72(%rsp), %r9
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%al, 0x42(%rsp)
               	movzbq	0x73(%rsp), %r9
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%al, 0x43(%rsp)
               	movzbq	0x74(%rsp), %r9
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%al, 0x44(%rsp)
               	movzbq	0x75(%rsp), %r9
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%al, 0x45(%rsp)
               	movzbq	0x76(%rsp), %r9
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%al, 0x46(%rsp)
               	movzbq	0x77(%rsp), %r9
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%al, 0x47(%rsp)
               	movzbq	0x78(%rsp), %r9
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%al, 0x48(%rsp)
               	movzbq	0x79(%rsp), %r9
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%al, 0x49(%rsp)
               	movzbq	0x7a(%rsp), %r9
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%al, 0x4a(%rsp)
               	movzbq	0x7b(%rsp), %r9
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%al, 0x4b(%rsp)
               	movzbq	0x7c(%rsp), %r9
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%al, 0x4c(%rsp)
               	movzbq	0x7d(%rsp), %r9
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%al, 0x4d(%rsp)
               	movzbq	0x7e(%rsp), %r9
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%al, 0x4e(%rsp)
               	movzbq	0x7f(%rsp), %r9
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%al, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rdi), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xfa, %eax
               	movzbq	0x70(%rsp,%rcx), %rdi
               	cltd
               	idivl	%edi
               	andq	$0xff, %rax
               	movb	%al, -0x10(%rbp,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rdx
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0xfa, %ecx
               	leaq	0x40(%rsp), %rdi
               	movzbq	0x70(%rsp), %r8
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x71(%rsp), %r8
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x72(%rsp), %r8
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x73(%rsp), %r8
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x74(%rsp), %r8
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x75(%rsp), %r8
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x76(%rsp), %r8
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x77(%rsp), %r8
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x78(%rsp), %r8
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x79(%rsp), %r8
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x7a(%rsp), %r8
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x7b(%rsp), %r8
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x7c(%rsp), %r8
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x7d(%rsp), %r8
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x7e(%rsp), %r8
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x7f(%rsp), %r8
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rdi), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xfa, %edi
               	movzbq	0x70(%rsp,%rcx), %r8
               	movl	%edi, %eax
               	cltd
               	idivl	%r8d
               	andq	$0xff, %rdx
               	movb	%dl, -0x10(%rbp,%rcx)
               	incq	%rcx
               	nop
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0xf, %eax
               	leaq	0x40(%rsp), %rdi
               	movzbq	0x70(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x71(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x72(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x73(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x74(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x75(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x76(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x77(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x78(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x79(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x7a(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x7b(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x7c(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x7d(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x7e(%rsp), %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x7f(%rsp), %rdx
               	andq	%rdx, %rax
               	movb	%al, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rdi), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movzbq	0x70(%rsp,%rax), %rdx
               	andq	$0xf, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x3, %eax
               	leaq	0x40(%rsp), %rdx
               	movzbq	0x160(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x40(%rsp)
               	movzbq	0x161(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x41(%rsp)
               	movzbq	0x162(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x42(%rsp)
               	movzbq	0x163(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x43(%rsp)
               	movzbq	0x164(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x44(%rsp)
               	movzbq	0x165(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x45(%rsp)
               	movzbq	0x166(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x46(%rsp)
               	movzbq	0x167(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x47(%rsp)
               	movzbq	0x168(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x48(%rsp)
               	movzbq	0x169(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x49(%rsp)
               	movzbq	0x16a(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x4a(%rsp)
               	movzbq	0x16b(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x4b(%rsp)
               	movzbq	0x16c(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x4c(%rsp)
               	movzbq	0x16d(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x4d(%rsp)
               	movzbq	0x16e(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x4e(%rsp)
               	movzbq	0x16f(%rsp), %rsi
               	shlxq	%rsi, %rax, %rax
               	movb	%al, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rdx), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movl	$0x3, %edx
               	movzbq	0x160(%rsp,%rax), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x80, %eax
               	leaq	0x40(%rsp), %rdx
               	movzbq	0x160(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x40(%rsp)
               	movzbq	0x161(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x41(%rsp)
               	movzbq	0x162(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x42(%rsp)
               	movzbq	0x163(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x43(%rsp)
               	movzbq	0x164(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x44(%rsp)
               	movzbq	0x165(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x45(%rsp)
               	movzbq	0x166(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x46(%rsp)
               	movzbq	0x167(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x47(%rsp)
               	movzbq	0x168(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x48(%rsp)
               	movzbq	0x169(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x49(%rsp)
               	movzbq	0x16a(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x4a(%rsp)
               	movzbq	0x16b(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x4b(%rsp)
               	movzbq	0x16c(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x4c(%rsp)
               	movzbq	0x16d(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x4d(%rsp)
               	movzbq	0x16e(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x4e(%rsp)
               	movzbq	0x16f(%rsp), %rsi
               	shrxq	%rsi, %rax, %rax
               	movb	%al, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rdx), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movl	$0x80, %edx
               	movzbq	0x160(%rsp,%rax), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rdx
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	$-0x7, %rcx
               	movslq	0x110(%rsp), %rdi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	movslq	0x114(%rsp), %r9
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movslq	0x118(%rsp), %r10
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r10
               	movslq	0x11c(%rsp), %r11
               	movq	%rcx, %rax
               	cqto
               	idivq	%r11
               	movl	%edi, 0x40(%rsp)
               	movl	%r9d, 0x44(%rsp)
               	movl	%r10d, 0x48(%rsp)
               	movl	%eax, 0x4c(%rsp)
               	xorl	%ecx, %ecx
               	movq	$-0x7, %rax
               	movl	0x110(%rsp,%rcx,4), %edi
               	cltd
               	idivl	%edi
               	movl	%eax, -0x10(%rbp,%rcx,4)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdx
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	$-0x7, %rcx
               	movslq	0x110(%rsp), %rdi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rdi
               	movslq	0x114(%rsp), %r8
               	movq	%rcx, %rax
               	cqto
               	idivq	%r8
               	movq	%rdx, %r8
               	movslq	0x118(%rsp), %r10
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %r10
               	movslq	0x11c(%rsp), %r11
               	movq	%rcx, %rax
               	cqto
               	idivq	%r11
               	movl	%edi, 0x40(%rsp)
               	movl	%r8d, 0x44(%rsp)
               	movl	%r10d, 0x48(%rsp)
               	movl	%edx, 0x4c(%rsp)
               	xorl	%ecx, %ecx
               	movq	$-0x7, %rdi
               	movl	0x110(%rsp,%rcx,4), %r8d
               	movl	%edi, %eax
               	cltd
               	idivl	%r8d
               	movl	%edx, -0x10(%rbp,%rcx,4)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rdx
               	movzbq	0x60(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	movb	%al, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	movb	%al, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	movb	%al, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	movb	%al, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	movb	%al, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	movb	%al, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	movb	%al, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	movb	%al, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	movb	%al, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	movb	%al, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	movb	%al, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	movb	%al, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	movb	%al, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	movb	%al, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	movb	%al, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	shrq	$0x20, %rax
               	movb	%al, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rdx), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movslq	0x100(%rsp), %rax
               	movl	$0x92492493, %r11d      # imm = 0x92492493
               	imulq	%r11, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rax, %rcx
               	movslq	0x104(%rsp), %rax
               	movl	$0x92492493, %r11d      # imm = 0x92492493
               	imulq	%r11, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rax, %rsi
               	movslq	0x108(%rsp), %rax
               	movl	$0x92492493, %r11d      # imm = 0x92492493
               	imulq	%r11, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %r8
               	shrq	$0x3f, %r8
               	addq	%rax, %r8
               	movslq	0x10c(%rsp), %rax
               	movl	$0x92492493, %r11d      # imm = 0x92492493
               	imulq	%r11, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %rax
               	movl	%ecx, 0x40(%rsp)
               	movl	%esi, 0x44(%rsp)
               	movl	%r8d, 0x48(%rsp)
               	movl	%eax, 0x4c(%rsp)
               	xorl	%eax, %eax
               	movl	$0x92492493, %r8d       # imm = 0x92492493
               	movslq	0x100(%rsp,%rax,4), %rcx
               	imulq	%r8, %rcx
               	sarq	$0x22, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rcx
               	movl	%ecx, -0x10(%rbp,%rax,4)
               	incq	%rax
               	nop
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movups	0x60(%rsp), %xmm0
               	movq	%rax, %xmm14
               	vpsubb	%xmm0, %xmm14, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movzbq	0x60(%rsp,%rax), %rdx
               	negq	%rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movups	0x80(%rsp), %xmm0
               	movq	%rax, %xmm14
               	vpsubb	%xmm0, %xmm14, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movsbq	0x80(%rsp,%rax), %rdx
               	negq	%rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movups	0x100(%rsp), %xmm0
               	movq	%rax, %xmm14
               	vpsubd	%xmm0, %xmm14, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movl	0x100(%rsp,%rax,4), %edx
               	negq	%rdx
               	movl	%edx, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	vpcmpeqd	%xmm0, %xmm0, %xmm0
               	movups	0x60(%rsp), %xmm1
               	vpxor	%xmm0, %xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rcx
               	xorq	$-0x1, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x10(%rbp,%rax)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	vpcmpeqd	%xmm0, %xmm0, %xmm0
               	movups	0x140(%rsp), %xmm1
               	vpxor	%xmm0, %xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movq	0x140(%rsp,%rax,8), %rdx
               	xorq	$-0x1, %rdx
               	movq	%rdx, -0x10(%rbp,%rax,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	vpaddb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x40(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	vpaddb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	0x20(%rsp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	vpsubb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x40(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	vpsubb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	0x20(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rsi
               	leaq	0x40(%rsp), %rcx
               	movzbq	0x60(%rsp), %rax
               	movzbq	0x70(%rsp), %rdx
               	imulq	%rdx, %rax
               	movb	%al, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rax
               	movzbq	0x71(%rsp), %rdx
               	imulq	%rdx, %rax
               	movb	%al, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rax
               	movzbq	0x72(%rsp), %rdx
               	imulq	%rdx, %rax
               	movb	%al, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rax
               	movzbq	0x73(%rsp), %rdx
               	imulq	%rdx, %rax
               	movb	%al, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rax
               	movzbq	0x74(%rsp), %rdx
               	imulq	%rdx, %rax
               	movb	%al, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rax
               	movzbq	0x75(%rsp), %rdx
               	imulq	%rdx, %rax
               	movb	%al, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rax
               	movzbq	0x76(%rsp), %rdx
               	imulq	%rdx, %rax
               	movb	%al, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rax
               	movzbq	0x77(%rsp), %rdx
               	imulq	%rdx, %rax
               	movb	%al, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rax
               	movzbq	0x78(%rsp), %rdx
               	imulq	%rdx, %rax
               	movb	%al, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rax
               	movzbq	0x79(%rsp), %rdx
               	imulq	%rdx, %rax
               	movb	%al, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rax
               	movzbq	0x7a(%rsp), %rdx
               	imulq	%rdx, %rax
               	movb	%al, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rax
               	movzbq	0x7b(%rsp), %rdx
               	imulq	%rdx, %rax
               	movb	%al, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rax
               	movzbq	0x7c(%rsp), %rdx
               	imulq	%rdx, %rax
               	movb	%al, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rax
               	movzbq	0x7d(%rsp), %rdx
               	imulq	%rdx, %rax
               	movb	%al, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rax
               	movzbq	0x7e(%rsp), %rdx
               	imulq	%rdx, %rax
               	movb	%al, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rax
               	movzbq	0x7f(%rsp), %rdx
               	imulq	%rdx, %rax
               	movb	%al, 0x4f(%rsp)
               	leaq	(%rsp), %rdx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rcx
               	vmovups	(%rsi), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rsi
               	movzbq	0x60(%rsp), %rax
               	movzbq	0x70(%rsp), %rdi
               	imulq	%rdi, %rax
               	movb	%al, 0x40(%rsp)
               	movzbq	0x21(%rsp), %rax
               	movzbq	0x71(%rsp), %rdi
               	imulq	%rdi, %rax
               	movb	%al, 0x41(%rsp)
               	movzbq	0x22(%rsp), %rax
               	movzbq	0x72(%rsp), %rdi
               	imulq	%rdi, %rax
               	movb	%al, 0x42(%rsp)
               	movzbq	0x23(%rsp), %rax
               	movzbq	0x73(%rsp), %rdi
               	imulq	%rdi, %rax
               	movb	%al, 0x43(%rsp)
               	movzbq	0x24(%rsp), %rax
               	movzbq	0x74(%rsp), %rdi
               	imulq	%rdi, %rax
               	movb	%al, 0x44(%rsp)
               	movzbq	0x25(%rsp), %rax
               	movzbq	0x75(%rsp), %rdi
               	imulq	%rdi, %rax
               	movb	%al, 0x45(%rsp)
               	movzbq	0x26(%rsp), %rax
               	movzbq	0x76(%rsp), %rdi
               	imulq	%rdi, %rax
               	movb	%al, 0x46(%rsp)
               	movzbq	0x27(%rsp), %rax
               	movzbq	0x77(%rsp), %rdi
               	imulq	%rdi, %rax
               	movb	%al, 0x47(%rsp)
               	movzbq	0x28(%rsp), %rax
               	movzbq	0x78(%rsp), %rdi
               	imulq	%rdi, %rax
               	movb	%al, 0x48(%rsp)
               	movzbq	0x29(%rsp), %rax
               	movzbq	0x79(%rsp), %rdi
               	imulq	%rdi, %rax
               	movb	%al, 0x49(%rsp)
               	movzbq	0x2a(%rsp), %rax
               	movzbq	0x7a(%rsp), %rdi
               	imulq	%rdi, %rax
               	movb	%al, 0x4a(%rsp)
               	movzbq	0x2b(%rsp), %rax
               	movzbq	0x7b(%rsp), %rdi
               	imulq	%rdi, %rax
               	movb	%al, 0x4b(%rsp)
               	movzbq	0x2c(%rsp), %rax
               	movzbq	0x7c(%rsp), %rdi
               	imulq	%rdi, %rax
               	movb	%al, 0x4c(%rsp)
               	movzbq	0x2d(%rsp), %rax
               	movzbq	0x7d(%rsp), %rdi
               	imulq	%rdi, %rax
               	movb	%al, 0x4d(%rsp)
               	movzbq	0x2e(%rsp), %rax
               	movzbq	0x7e(%rsp), %rdi
               	imulq	%rdi, %rax
               	movb	%al, 0x4e(%rsp)
               	movzbq	0x2f(%rsp), %rax
               	movzbq	0x7f(%rsp), %rdi
               	imulq	%rdi, %rax
               	movb	%al, 0x4f(%rsp)
               	vmovups	(%rsi), %xmm14
               	vmovups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	0x40(%rsp), %rcx
               	movzbq	0x60(%rsp), %rax
               	movzbq	0x70(%rsp), %rsi
               	xorl	%edx, %edx
               	divl	%esi
               	movb	%al, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rax
               	movzbq	0x71(%rsp), %rsi
               	xorl	%edx, %edx
               	divl	%esi
               	movb	%al, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rax
               	movzbq	0x72(%rsp), %rsi
               	xorl	%edx, %edx
               	divl	%esi
               	movb	%al, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rax
               	movzbq	0x73(%rsp), %rsi
               	xorl	%edx, %edx
               	divl	%esi
               	movb	%al, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rax
               	movzbq	0x74(%rsp), %rsi
               	xorl	%edx, %edx
               	divl	%esi
               	movb	%al, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rax
               	movzbq	0x75(%rsp), %rsi
               	xorl	%edx, %edx
               	divl	%esi
               	movb	%al, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rax
               	movzbq	0x76(%rsp), %rsi
               	xorl	%edx, %edx
               	divl	%esi
               	movb	%al, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rax
               	movzbq	0x77(%rsp), %rsi
               	xorl	%edx, %edx
               	divl	%esi
               	movb	%al, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rax
               	movzbq	0x78(%rsp), %rsi
               	xorl	%edx, %edx
               	divl	%esi
               	movb	%al, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rax
               	movzbq	0x79(%rsp), %rsi
               	xorl	%edx, %edx
               	divl	%esi
               	movb	%al, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rax
               	movzbq	0x7a(%rsp), %rsi
               	xorl	%edx, %edx
               	divl	%esi
               	movb	%al, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rax
               	movzbq	0x7b(%rsp), %rsi
               	xorl	%edx, %edx
               	divl	%esi
               	movb	%al, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rax
               	movzbq	0x7c(%rsp), %rsi
               	xorl	%edx, %edx
               	divl	%esi
               	movb	%al, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rax
               	movzbq	0x7d(%rsp), %rsi
               	xorl	%edx, %edx
               	divl	%esi
               	movb	%al, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rax
               	movzbq	0x7e(%rsp), %rsi
               	xorl	%edx, %edx
               	divl	%esi
               	movb	%al, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rax
               	movzbq	0x7f(%rsp), %rsi
               	xorl	%edx, %edx
               	divl	%esi
               	movb	%al, 0x4f(%rsp)
               	leaq	(%rsp), %rsi
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rsi)
               	leaq	0x20(%rsp), %rcx
               	vmovups	(%rdi), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rdi
               	movzbq	0x60(%rsp), %rax
               	movzbq	0x70(%rsp), %r8
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%al, 0x40(%rsp)
               	movzbq	0x21(%rsp), %rax
               	movzbq	0x71(%rsp), %r8
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%al, 0x41(%rsp)
               	movzbq	0x22(%rsp), %rax
               	movzbq	0x72(%rsp), %r8
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%al, 0x42(%rsp)
               	movzbq	0x23(%rsp), %rax
               	movzbq	0x73(%rsp), %r8
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%al, 0x43(%rsp)
               	movzbq	0x24(%rsp), %rax
               	movzbq	0x74(%rsp), %r8
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%al, 0x44(%rsp)
               	movzbq	0x25(%rsp), %rax
               	movzbq	0x75(%rsp), %r8
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%al, 0x45(%rsp)
               	movzbq	0x26(%rsp), %rax
               	movzbq	0x76(%rsp), %r8
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%al, 0x46(%rsp)
               	movzbq	0x27(%rsp), %rax
               	movzbq	0x77(%rsp), %r8
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%al, 0x47(%rsp)
               	movzbq	0x28(%rsp), %rax
               	movzbq	0x78(%rsp), %r8
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%al, 0x48(%rsp)
               	movzbq	0x29(%rsp), %rax
               	movzbq	0x79(%rsp), %r8
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%al, 0x49(%rsp)
               	movzbq	0x2a(%rsp), %rax
               	movzbq	0x7a(%rsp), %r8
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%al, 0x4a(%rsp)
               	movzbq	0x2b(%rsp), %rax
               	movzbq	0x7b(%rsp), %r8
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%al, 0x4b(%rsp)
               	movzbq	0x2c(%rsp), %rax
               	movzbq	0x7c(%rsp), %r8
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%al, 0x4c(%rsp)
               	movzbq	0x2d(%rsp), %rax
               	movzbq	0x7d(%rsp), %r8
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%al, 0x4d(%rsp)
               	movzbq	0x2e(%rsp), %rax
               	movzbq	0x7e(%rsp), %r8
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%al, 0x4e(%rsp)
               	movzbq	0x2f(%rsp), %rax
               	movzbq	0x7f(%rsp), %r8
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%al, 0x4f(%rsp)
               	vmovups	(%rdi), %xmm14
               	vmovups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rdx
               	movzbq	(%rsp,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	0x40(%rsp), %rcx
               	movzbq	0x60(%rsp), %rsi
               	movzbq	0x70(%rsp), %r8
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rsi
               	movzbq	0x71(%rsp), %r8
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rsi
               	movzbq	0x72(%rsp), %r8
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rsi
               	movzbq	0x73(%rsp), %r8
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rsi
               	movzbq	0x74(%rsp), %r8
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rsi
               	movzbq	0x75(%rsp), %r8
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rsi
               	movzbq	0x76(%rsp), %r8
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rsi
               	movzbq	0x77(%rsp), %r8
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rsi
               	movzbq	0x78(%rsp), %r8
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rsi
               	movzbq	0x79(%rsp), %r8
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rsi
               	movzbq	0x7a(%rsp), %r8
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rsi
               	movzbq	0x7b(%rsp), %r8
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rsi
               	movzbq	0x7c(%rsp), %r8
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rsi
               	movzbq	0x7d(%rsp), %r8
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rsi
               	movzbq	0x7e(%rsp), %r8
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rsi
               	movzbq	0x7f(%rsp), %r8
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4f(%rsp)
               	leaq	(%rsp), %rsi
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rsi)
               	leaq	0x20(%rsp), %rcx
               	vmovups	(%rdi), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rdi
               	movzbq	0x60(%rsp), %r8
               	movzbq	0x70(%rsp), %r9
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x21(%rsp), %r8
               	movzbq	0x71(%rsp), %r9
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x22(%rsp), %r8
               	movzbq	0x72(%rsp), %r9
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x23(%rsp), %r8
               	movzbq	0x73(%rsp), %r9
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x24(%rsp), %r8
               	movzbq	0x74(%rsp), %r9
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x25(%rsp), %r8
               	movzbq	0x75(%rsp), %r9
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x26(%rsp), %r8
               	movzbq	0x76(%rsp), %r9
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x27(%rsp), %r8
               	movzbq	0x77(%rsp), %r9
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x28(%rsp), %r8
               	movzbq	0x78(%rsp), %r9
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x29(%rsp), %r8
               	movzbq	0x79(%rsp), %r9
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x2a(%rsp), %r8
               	movzbq	0x7a(%rsp), %r9
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x2b(%rsp), %r8
               	movzbq	0x7b(%rsp), %r9
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x2c(%rsp), %r8
               	movzbq	0x7c(%rsp), %r9
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x2d(%rsp), %r8
               	movzbq	0x7d(%rsp), %r9
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x2e(%rsp), %r8
               	movzbq	0x7e(%rsp), %r9
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x2f(%rsp), %r8
               	movzbq	0x7f(%rsp), %r9
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%r9d
               	movb	%dl, 0x4f(%rsp)
               	vmovups	(%rdi), %xmm14
               	vmovups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rdx
               	movzbq	(%rsp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	vpand	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x40(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	vpand	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	0x20(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	vpor	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x40(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	vpor	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	0x20(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nopw	(%rax,%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	vpxor	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x40(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	vpxor	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	0x20(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movzbq	0x60(%rsp), %rdx
               	movzbq	0x160(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	movzbq	0x161(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	movzbq	0x162(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	movzbq	0x163(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	movzbq	0x164(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	movzbq	0x165(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	movzbq	0x166(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	movzbq	0x167(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	movzbq	0x168(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	movzbq	0x169(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	movzbq	0x16a(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	movzbq	0x16b(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	movzbq	0x16c(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	movzbq	0x16d(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	movzbq	0x16e(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	movzbq	0x16f(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x4f(%rsp)
               	leaq	(%rsp), %rdx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	movzbq	0x60(%rsp), %rsi
               	movzbq	0x160(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x40(%rsp)
               	movzbq	0x21(%rsp), %rsi
               	movzbq	0x161(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x41(%rsp)
               	movzbq	0x22(%rsp), %rsi
               	movzbq	0x162(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x42(%rsp)
               	movzbq	0x23(%rsp), %rsi
               	movzbq	0x163(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x43(%rsp)
               	movzbq	0x24(%rsp), %rsi
               	movzbq	0x164(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x44(%rsp)
               	movzbq	0x25(%rsp), %rsi
               	movzbq	0x165(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x45(%rsp)
               	movzbq	0x26(%rsp), %rsi
               	movzbq	0x166(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x46(%rsp)
               	movzbq	0x27(%rsp), %rsi
               	movzbq	0x167(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x47(%rsp)
               	movzbq	0x28(%rsp), %rsi
               	movzbq	0x168(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x48(%rsp)
               	movzbq	0x29(%rsp), %rsi
               	movzbq	0x169(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x49(%rsp)
               	movzbq	0x2a(%rsp), %rsi
               	movzbq	0x16a(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x4a(%rsp)
               	movzbq	0x2b(%rsp), %rsi
               	movzbq	0x16b(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x4b(%rsp)
               	movzbq	0x2c(%rsp), %rsi
               	movzbq	0x16c(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x4c(%rsp)
               	movzbq	0x2d(%rsp), %rsi
               	movzbq	0x16d(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x4d(%rsp)
               	movzbq	0x2e(%rsp), %rsi
               	movzbq	0x16e(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x4e(%rsp)
               	movzbq	0x2f(%rsp), %rsi
               	movzbq	0x16f(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x4f(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	(%rsp,%rax), %rdi
               	nopl	(%rax,%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movzbq	0x60(%rsp), %rdx
               	movzbq	0x160(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	movzbq	0x161(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	movzbq	0x162(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	movzbq	0x163(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	movzbq	0x164(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	movzbq	0x165(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	movzbq	0x166(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	movzbq	0x167(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	movzbq	0x168(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	movzbq	0x169(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	movzbq	0x16a(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	movzbq	0x16b(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	movzbq	0x16c(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	movzbq	0x16d(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	movzbq	0x16e(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	movzbq	0x16f(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x4f(%rsp)
               	leaq	(%rsp), %rdx
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	movzbq	0x60(%rsp), %rsi
               	movzbq	0x160(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x40(%rsp)
               	movzbq	0x21(%rsp), %rsi
               	movzbq	0x161(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x41(%rsp)
               	movzbq	0x22(%rsp), %rsi
               	movzbq	0x162(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x42(%rsp)
               	movzbq	0x23(%rsp), %rsi
               	movzbq	0x163(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x43(%rsp)
               	movzbq	0x24(%rsp), %rsi
               	movzbq	0x164(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x44(%rsp)
               	movzbq	0x25(%rsp), %rsi
               	movzbq	0x165(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x45(%rsp)
               	movzbq	0x26(%rsp), %rsi
               	movzbq	0x166(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x46(%rsp)
               	movzbq	0x27(%rsp), %rsi
               	movzbq	0x167(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x47(%rsp)
               	movzbq	0x28(%rsp), %rsi
               	movzbq	0x168(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x48(%rsp)
               	movzbq	0x29(%rsp), %rsi
               	movzbq	0x169(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x49(%rsp)
               	movzbq	0x2a(%rsp), %rsi
               	movzbq	0x16a(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x4a(%rsp)
               	movzbq	0x2b(%rsp), %rsi
               	movzbq	0x16b(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x4b(%rsp)
               	movzbq	0x2c(%rsp), %rsi
               	movzbq	0x16c(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x4c(%rsp)
               	movzbq	0x2d(%rsp), %rsi
               	movzbq	0x16d(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x4d(%rsp)
               	movzbq	0x2e(%rsp), %rsi
               	movzbq	0x16e(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x4e(%rsp)
               	movzbq	0x2f(%rsp), %rsi
               	movzbq	0x16f(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x4f(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movswq	0xc0(%rsp), %rax
               	movswq	0xd0(%rsp), %rcx
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	movswq	0xc2(%rsp), %rax
               	movswq	0xd2(%rsp), %rsi
               	cqto
               	idivq	%rsi
               	movq	%rax, %rsi
               	movswq	0xc4(%rsp), %rax
               	movswq	0xd4(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	movswq	0xc6(%rsp), %rax
               	movswq	0xd6(%rsp), %r8
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	movswq	0xc8(%rsp), %rax
               	movswq	0xd8(%rsp), %r9
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movswq	0xca(%rsp), %rax
               	movswq	0xda(%rsp), %r10
               	cqto
               	idivq	%r10
               	movq	%rax, %r10
               	movswq	0xcc(%rsp), %rax
               	movswq	0xdc(%rsp), %r11
               	cqto
               	idivq	%r11
               	movq	%rax, %r11
               	movswq	0xce(%rsp), %rax
               	movswq	0xde(%rsp), %rdx
               	movq	%r10, -0x90(%rbp)
               	movq	%rdx, %r10
               	cqto
               	idivq	%r10
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, 0x20(%rsp)
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movw	%si, 0x22(%rsp)
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movw	%di, 0x24(%rsp)
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	movw	%r8w, 0x26(%rsp)
               	movq	-0x90(%rbp), %r10
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movw	%r9w, 0x28(%rsp)
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movw	%r10w, 0x2a(%rsp)
               	andq	$0xffff, %r11           # imm = 0xFFFF
               	movw	%r11w, 0x2c(%rsp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x2e(%rsp)
               	leaq	0xc0(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	movswq	0xc0(%rsp), %rax
               	movswq	0xd0(%rsp), %rcx
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	movswq	0xc2(%rsp), %rax
               	movswq	0xd2(%rsp), %rsi
               	cqto
               	idivq	%rsi
               	movq	%rax, %rsi
               	movswq	0xc4(%rsp), %rax
               	movswq	0xd4(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	movswq	0xc6(%rsp), %rax
               	movswq	0xd6(%rsp), %r8
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	movswq	0xc8(%rsp), %rax
               	movswq	0xd8(%rsp), %r9
               	cqto
               	idivq	%r9
               	movq	%rax, %r9
               	movswq	0xca(%rsp), %rax
               	movswq	0xda(%rsp), %r10
               	cqto
               	idivq	%r10
               	movq	%rax, %r10
               	movswq	0xcc(%rsp), %rax
               	movswq	0xdc(%rsp), %r11
               	cqto
               	idivq	%r11
               	movq	%rax, %r11
               	movswq	0xce(%rsp), %rax
               	movswq	0xde(%rsp), %rdx
               	movq	%r10, -0x90(%rbp)
               	movq	%rdx, %r10
               	cqto
               	idivq	%r10
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, 0x40(%rsp)
               	andq	$0xffff, %rsi           # imm = 0xFFFF
               	movw	%si, 0x42(%rsp)
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movw	%di, 0x44(%rsp)
               	andq	$0xffff, %r8            # imm = 0xFFFF
               	movw	%r8w, 0x46(%rsp)
               	movq	-0x90(%rbp), %r10
               	andq	$0xffff, %r9            # imm = 0xFFFF
               	movw	%r9w, 0x48(%rsp)
               	andq	$0xffff, %r10           # imm = 0xFFFF
               	movw	%r10w, 0x4a(%rsp)
               	andq	$0xffff, %r11           # imm = 0xFFFF
               	movw	%r11w, 0x4c(%rsp)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, 0x4e(%rsp)
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	0x20(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %rdx
               	movq	0x140(%rsp), %rax
               	movq	0x150(%rsp), %rcx
               	imulq	%rcx, %rax
               	movq	0x148(%rsp), %rcx
               	movq	0x158(%rsp), %rsi
               	imulq	%rsi, %rcx
               	movq	%rax, 0x20(%rsp)
               	movq	%rcx, 0x28(%rsp)
               	leaq	0x40(%rsp), %rcx
               	vmovups	(%rdx), %xmm14
               	vmovups	%xmm14, (%rcx)
               	movq	0x140(%rsp), %rax
               	movq	0x150(%rsp), %rdx
               	imulq	%rdx, %rax
               	movq	0x148(%rsp), %rdx
               	movq	0x158(%rsp), %rdi
               	imulq	%rdi, %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	%rdx, 0x48(%rsp)
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdx
               	movzbq	0x20(%rsp,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	leaq	(%rsp), %rcx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	movzbq	0x60(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x1(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x2(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x3(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x4(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x5(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x6(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x7(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x8(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x9(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0xa(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0xb(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0xc(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0xd(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0xe(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0xf(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4f(%rsp)
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	movzbq	0x60(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rdx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rsp,%rax), %rsi
               	movzbq	0x20(%rsp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rdx
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rdx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	0x40(%rsp), %rcx
               	movzbq	0x60(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x40(%rsp)
               	movzbq	0x21(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x41(%rsp)
               	movzbq	0x22(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x42(%rsp)
               	movzbq	0x23(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x43(%rsp)
               	movzbq	0x24(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x44(%rsp)
               	movzbq	0x25(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x45(%rsp)
               	movzbq	0x26(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x46(%rsp)
               	movzbq	0x27(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x47(%rsp)
               	movzbq	0x28(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x48(%rsp)
               	movzbq	0x29(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x49(%rsp)
               	movzbq	0x2a(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4a(%rsp)
               	movzbq	0x2b(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4b(%rsp)
               	movzbq	0x2c(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4c(%rsp)
               	movzbq	0x2d(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4d(%rsp)
               	movzbq	0x2e(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4e(%rsp)
               	movzbq	0x2f(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4f(%rsp)
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	0x40(%rsp), %rcx
               	movzbq	0x40(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x40(%rsp)
               	movzbq	0x21(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x41(%rsp)
               	movzbq	0x22(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x42(%rsp)
               	movzbq	0x23(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x43(%rsp)
               	movzbq	0x24(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x44(%rsp)
               	movzbq	0x25(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x45(%rsp)
               	movzbq	0x26(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x46(%rsp)
               	movzbq	0x27(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x47(%rsp)
               	movzbq	0x28(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x48(%rsp)
               	movzbq	0x29(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x49(%rsp)
               	movzbq	0x2a(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4a(%rsp)
               	movzbq	0x2b(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4b(%rsp)
               	movzbq	0x2c(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4c(%rsp)
               	movzbq	0x2d(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4d(%rsp)
               	movzbq	0x2e(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4e(%rsp)
               	movzbq	0x2f(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4f(%rsp)
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	leaq	0x40(%rsp), %rcx
               	movzbq	0x40(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x40(%rsp)
               	movzbq	0x21(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x41(%rsp)
               	movzbq	0x22(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x42(%rsp)
               	movzbq	0x23(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x43(%rsp)
               	movzbq	0x24(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x44(%rsp)
               	movzbq	0x25(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x45(%rsp)
               	movzbq	0x26(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x46(%rsp)
               	movzbq	0x27(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x47(%rsp)
               	movzbq	0x28(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x48(%rsp)
               	movzbq	0x29(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x49(%rsp)
               	movzbq	0x2a(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4a(%rsp)
               	movzbq	0x2b(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4b(%rsp)
               	movzbq	0x2c(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4c(%rsp)
               	movzbq	0x2d(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4d(%rsp)
               	movzbq	0x2e(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4e(%rsp)
               	movzbq	0x2f(%rsp), %rsi
               	subq	$0x40, %rsi
               	movb	%sil, 0x4f(%rsp)
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rcx
               	subq	$0xc0, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	nop
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	vpaddb	%xmm1, %xmm0, %xmm0
               	movl	$0x3, %eax
               	vpextrb	$0x0, %xmm0, %ecx
               	imulq	%rax, %rcx
               	vpinsrb	$0x0, %ecx, %xmm1, %xmm1
               	vpextrb	$0x1, %xmm0, %ecx
               	imulq	%rax, %rcx
               	vpinsrb	$0x1, %ecx, %xmm1, %xmm1
               	vpextrb	$0x2, %xmm0, %ecx
               	imulq	%rax, %rcx
               	vpinsrb	$0x2, %ecx, %xmm1, %xmm1
               	vpextrb	$0x3, %xmm0, %ecx
               	imulq	%rax, %rcx
               	vpinsrb	$0x3, %ecx, %xmm1, %xmm1
               	vpextrb	$0x4, %xmm0, %ecx
               	imulq	%rax, %rcx
               	vpinsrb	$0x4, %ecx, %xmm1, %xmm1
               	vpextrb	$0x5, %xmm0, %ecx
               	imulq	%rax, %rcx
               	vpinsrb	$0x5, %ecx, %xmm1, %xmm1
               	vpextrb	$0x6, %xmm0, %ecx
               	imulq	%rax, %rcx
               	vpinsrb	$0x6, %ecx, %xmm1, %xmm1
               	vpextrb	$0x7, %xmm0, %ecx
               	imulq	%rax, %rcx
               	vpinsrb	$0x7, %ecx, %xmm1, %xmm1
               	vpextrb	$0x8, %xmm0, %ecx
               	imulq	%rax, %rcx
               	vpinsrb	$0x8, %ecx, %xmm1, %xmm1
               	vpextrb	$0x9, %xmm0, %ecx
               	imulq	%rax, %rcx
               	vpinsrb	$0x9, %ecx, %xmm1, %xmm1
               	vpextrb	$0xa, %xmm0, %ecx
               	imulq	%rax, %rcx
               	vpinsrb	$0xa, %ecx, %xmm1, %xmm1
               	vpextrb	$0xb, %xmm0, %ecx
               	imulq	%rax, %rcx
               	vpinsrb	$0xb, %ecx, %xmm1, %xmm1
               	vpextrb	$0xc, %xmm0, %ecx
               	imulq	%rax, %rcx
               	vpinsrb	$0xc, %ecx, %xmm1, %xmm1
               	vpextrb	$0xd, %xmm0, %ecx
               	imulq	%rax, %rcx
               	vpinsrb	$0xd, %ecx, %xmm1, %xmm1
               	vpextrb	$0xe, %xmm0, %ecx
               	imulq	%rax, %rcx
               	vpinsrb	$0xe, %ecx, %xmm1, %xmm1
               	vpextrb	$0xf, %xmm0, %ecx
               	imulq	%rax, %rcx
               	movapd	%xmm1, %xmm0
               	vpinsrb	$0xf, %ecx, %xmm0, %xmm0
               	movups	0x60(%rsp), %xmm1
               	vpsubb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rsi
               	movzbq	0x70(%rsp,%rax), %rcx
               	addq	%rsi, %rcx
               	andq	$0xff, %rcx
               	leaq	(%rcx,%rcx,2), %rcx
               	andq	$0xff, %rcx
               	subq	%rsi, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, -0x10(%rbp,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	nopl	(%rax)
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movslq	0x100(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	vmovd	%eax, %xmm0
               	movslq	0x104(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	vpinsrd	$0x1, %eax, %xmm0, %xmm0
               	movslq	0x108(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	vpinsrd	$0x2, %eax, %xmm0, %xmm0
               	movslq	0x10c(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rcx, %rax
               	vpinsrd	$0x3, %eax, %xmm0, %xmm0
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	vpsubd	%xmm0, %xmm14, %xmm0
               	movups	0x110(%rsp), %xmm1
               	vpaddd	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	movslq	0x100(%rsp,%rax,4), %rcx
               	imulq	$0x55555556, %rcx, %rcx # imm = 0x55555556
               	sarq	$0x20, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rcx, %rsi
               	movl	0x110(%rsp,%rax,4), %ecx
               	subq	%rsi, %rcx
               	movl	%ecx, -0x10(%rbp,%rax,4)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x60(%rsp), %xmm0
               	vpextrb	$0x0, %xmm0, %eax
               	shlq	%rax
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
               	vpextrb	$0x0, %xmm0, %ecx
               	movsbq	%cl, %rcx
               	sarq	$0x7, %rcx
               	vpextrb	$0x1, %xmm0, %edx
               	movsbq	%dl, %rdx
               	sarq	$0x7, %rdx
               	vpextrb	$0x2, %xmm0, %esi
               	movsbq	%sil, %rsi
               	sarq	$0x7, %rsi
               	vpextrb	$0x3, %xmm0, %edi
               	movsbq	%dil, %rdi
               	sarq	$0x7, %rdi
               	vpextrb	$0x4, %xmm0, %r8d
               	movsbq	%r8b, %r8
               	sarq	$0x7, %r8
               	vpextrb	$0x5, %xmm0, %r9d
               	movsbq	%r9b, %r9
               	sarq	$0x7, %r9
               	vpextrb	$0x6, %xmm0, %r10d
               	movsbq	%r10b, %r10
               	sarq	$0x7, %r10
               	vpextrb	$0x7, %xmm0, %r11d
               	movsbq	%r11b, %r11
               	sarq	$0x7, %r11
               	movq	%r10, -0x90(%rbp)
               	vpextrb	$0x8, %xmm0, %r10d
               	movsbq	%r10b, %r10
               	movq	%r10, -0x48(%rbp)
               	sarq	$0x7, %r10
               	movq	%r10, -0x48(%rbp)
               	vpextrb	$0x9, %xmm0, %r10d
               	movsbq	%r10b, %r10
               	movq	%r10, -0x50(%rbp)
               	sarq	$0x7, %r10
               	movq	%r10, -0x50(%rbp)
               	vpextrb	$0xa, %xmm0, %r10d
               	movsbq	%r10b, %r10
               	movq	%r10, -0x58(%rbp)
               	sarq	$0x7, %r10
               	movq	%r10, -0x58(%rbp)
               	vpextrb	$0xb, %xmm0, %r10d
               	movsbq	%r10b, %r10
               	movq	%r10, -0x60(%rbp)
               	sarq	$0x7, %r10
               	movq	%r10, -0x60(%rbp)
               	vpextrb	$0xc, %xmm0, %r10d
               	movsbq	%r10b, %r10
               	movq	%r10, -0x68(%rbp)
               	sarq	$0x7, %r10
               	movq	%r10, -0x68(%rbp)
               	vpextrb	$0xd, %xmm0, %r10d
               	movsbq	%r10b, %r10
               	movq	%r10, -0x70(%rbp)
               	sarq	$0x7, %r10
               	movq	%r10, -0x70(%rbp)
               	vpextrb	$0xe, %xmm0, %r10d
               	movsbq	%r10b, %r10
               	movq	%r10, -0x78(%rbp)
               	sarq	$0x7, %r10
               	movq	%r10, -0x78(%rbp)
               	vpextrb	$0xf, %xmm0, %r10d
               	movsbq	%r10b, %r10
               	movq	%r10, -0x80(%rbp)
               	sarq	$0x7, %r10
               	movq	%r10, -0x80(%rbp)
               	movl	$0x1b, %eax
               	movsbq	%cl, %rcx
               	andq	%rax, %rcx
               	movq	%r11, -0x98(%rbp)
               	vpinsrb	$0x0, %ecx, %xmm0, %xmm0
               	movsbq	%dl, %rcx
               	andq	%rax, %rcx
               	vpinsrb	$0x1, %ecx, %xmm0, %xmm0
               	movsbq	%sil, %rcx
               	andq	%rax, %rcx
               	vpinsrb	$0x2, %ecx, %xmm0, %xmm0
               	movsbq	%dil, %rcx
               	andq	%rax, %rcx
               	vpinsrb	$0x3, %ecx, %xmm0, %xmm0
               	movsbq	%r8b, %rcx
               	movq	-0x90(%rbp), %r10
               	andq	%rax, %rcx
               	vpinsrb	$0x4, %ecx, %xmm0, %xmm0
               	movsbq	%r9b, %rcx
               	movq	-0x98(%rbp), %r11
               	andq	%rax, %rcx
               	vpinsrb	$0x5, %ecx, %xmm0, %xmm0
               	movsbq	%r10b, %rcx
               	andq	%rax, %rcx
               	vpinsrb	$0x6, %ecx, %xmm0, %xmm0
               	movsbq	%r11b, %rcx
               	andq	%rax, %rcx
               	vpinsrb	$0x7, %ecx, %xmm0, %xmm0
               	movq	-0x48(%rbp), %rcx
               	movsbq	%cl, %rcx
               	andq	%rax, %rcx
               	vpinsrb	$0x8, %ecx, %xmm0, %xmm0
               	movq	-0x50(%rbp), %rcx
               	movsbq	%cl, %rcx
               	andq	%rax, %rcx
               	vpinsrb	$0x9, %ecx, %xmm0, %xmm0
               	movq	-0x58(%rbp), %rcx
               	movsbq	%cl, %rcx
               	andq	%rax, %rcx
               	vpinsrb	$0xa, %ecx, %xmm0, %xmm0
               	movq	-0x60(%rbp), %rcx
               	movsbq	%cl, %rcx
               	andq	%rax, %rcx
               	vpinsrb	$0xb, %ecx, %xmm0, %xmm0
               	movq	-0x68(%rbp), %rcx
               	movsbq	%cl, %rcx
               	andq	%rax, %rcx
               	vpinsrb	$0xc, %ecx, %xmm0, %xmm0
               	movq	-0x70(%rbp), %rcx
               	movsbq	%cl, %rcx
               	andq	%rax, %rcx
               	vpinsrb	$0xd, %ecx, %xmm0, %xmm0
               	movq	-0x78(%rbp), %rcx
               	movsbq	%cl, %rcx
               	andq	%rax, %rcx
               	vpinsrb	$0xe, %ecx, %xmm0, %xmm0
               	movq	-0x80(%rbp), %rcx
               	movsbq	%cl, %rcx
               	andq	%rax, %rcx
               	vpinsrb	$0xf, %ecx, %xmm0, %xmm0
               	vpxor	%xmm0, %xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rcx
               	movsbq	%cl, %rdx
               	sarq	$0x7, %rdx
               	andq	$0x1b, %rdx
               	shlq	%rcx
               	andq	$0xff, %rcx
               	xorq	%rdx, %rcx
               	movb	%cl, -0x10(%rbp,%rax)
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movups	0x60(%rsp), %xmm0
               	movups	0x80(%rsp), %xmm1
               	vpaddb	%xmm1, %xmm0, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	0x60(%rsp,%rax), %rdx
               	movzbq	0x80(%rsp,%rax), %rsi
               	addq	%rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, -0x10(%rbp,%rax)
               	incq	%rax
               	nopl	(%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x40(%rsp,%rax), %rdx
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	nop
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x160(%rsp), %rdi
               	leaq	<rip>, %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rdi)
               	leaq	(%rsp), %r8
               	leaq	<rip>, %rax
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%r8)
               	leaq	0x40(%rsp), %rax
               	xorl	%ecx, %ecx
               	movl	$0x280042, 0x40(%rsp)   # imm = 0x280042
               	movl	$0x16001d, 0x44(%rsp)   # imm = 0x16001D
               	movl	$0x4030201, 0x48(%rsp)  # imm = 0x4030201
               	movl	$0x8070605, 0x4c(%rsp)  # imm = 0x8070605
               	leaq	0x20(%rsp), %rdx
               	vmovups	(%rax), %xmm14
               	vmovups	%xmm14, (%rdx)
               	movzbq	0x160(%rsp,%rcx), %rax
               	movzbq	(%rsp,%rcx), %r9
               	cltd
               	idivl	%r9d
               	andq	$0xff, %rax
               	movb	%al, -0x10(%rbp,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rdx
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	movsbq	0x160(%rsp), %rax
               	movsbq	(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x40(%rsp)
               	movsbq	0x161(%rsp), %rax
               	movsbq	0x1(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x41(%rsp)
               	movsbq	0x162(%rsp), %rax
               	movsbq	0x2(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x42(%rsp)
               	movsbq	0x163(%rsp), %rax
               	movsbq	0x3(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x43(%rsp)
               	movsbq	0x164(%rsp), %rax
               	movsbq	0x4(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x44(%rsp)
               	movsbq	0x165(%rsp), %rax
               	movsbq	0x5(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x45(%rsp)
               	movsbq	0x166(%rsp), %rax
               	movsbq	0x6(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x46(%rsp)
               	movsbq	0x167(%rsp), %rax
               	movsbq	0x7(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x47(%rsp)
               	movsbq	0x168(%rsp), %rax
               	movsbq	0x8(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x48(%rsp)
               	movsbq	0x169(%rsp), %rax
               	movsbq	0x9(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x49(%rsp)
               	movsbq	0x16a(%rsp), %rax
               	movsbq	0xa(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x4a(%rsp)
               	movsbq	0x16b(%rsp), %rax
               	movsbq	0xb(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x4b(%rsp)
               	movsbq	0x16c(%rsp), %rax
               	movsbq	0xc(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x4c(%rsp)
               	movsbq	0x16d(%rsp), %rax
               	movsbq	0xd(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x4d(%rsp)
               	movsbq	0x16e(%rsp), %rax
               	movsbq	0xe(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x4e(%rsp)
               	movsbq	0x16f(%rsp), %rax
               	movsbq	0xf(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	vmovups	(%rcx), %xmm14
               	vmovups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movsbq	0x160(%rsp,%rcx), %rax
               	movsbq	(%rsp,%rcx), %rdi
               	cltd
               	idivl	%edi
               	movb	%al, -0x10(%rbp,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	xorl	%eax, %eax
               	movzbq	0x20(%rsp,%rax), %rsi
               	movzbq	-0x10(%rbp,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	nopl	(%rax,%rax)
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x68, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x67, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x5f, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x5e, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x5d, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x5c, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x5b, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x5a, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x59, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x58, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x57, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x56, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x55, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x54, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x53, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x52, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x51, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x50, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x4f, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x4e, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x4d, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x4c, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x4b, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x4a, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x49, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x60, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x48, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x66, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x65, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x64, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x63, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x62, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x61, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x47, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x46, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x45, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x44, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x43, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x42, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x41, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x40, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x3f, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x3e, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x3d, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x3c, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x3b, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x3a, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x39, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x38, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x37, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x36, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x35, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x34, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x33, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x32, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x31, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x30, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x2f, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x2e, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x2d, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x2c, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x2b, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x2a, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x29, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x28, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x27, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x26, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x25, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x24, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x23, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x22, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x21, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x20, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x1f, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x1e, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x1d, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x1c, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x1b, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x1a, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x19, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x18, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x17, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x16, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x15, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x14, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x13, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x12, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x11, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x10, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0xf, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0xe, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0xd, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0xc, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0xb, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0xa, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x9, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x8, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x7, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x6, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x5, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x4, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x3, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x2, %eax
               	vzeroupper
               	leave
               	retq
               	movl	$0x1, %eax
               	vzeroupper
               	leave
               	retq
