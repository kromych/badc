
gcc_vector_arith_ops.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x78, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x180, %rsp            # imm = 0x180
               	andq	$-0x20, %rsp
               	leaq	0x60(%rsp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x70(%rsp), %rdx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x80(%rsp), %rax
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x90(%rsp), %rax
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xa0(%rsp), %rax
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xb0(%rsp), %rax
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xc0(%rsp), %rax
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xd0(%rsp), %rax
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xe0(%rsp), %rax
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0xf0(%rsp), %rax
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x100(%rsp), %rax
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x110(%rsp), %rax
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x120(%rsp), %rax
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x130(%rsp), %rax
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x140(%rsp), %rax
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x150(%rsp), %rax
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x38(%rbp), %rax
               	leaq	<rip>, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rax)
               	leaq	-0x30(%rbp), %rax
               	leaq	<rip>, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, (%rax)
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rsi
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	paddb	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	movzbq	(%rdx,%rax), %r8
               	addq	%r8, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	0x70(%rsp), %r8
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	psubb	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rdi,%rax), %rdx
               	movzbq	(%r8,%rax), %rsi
               	subq	%rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	0x70(%rsp), %r8
               	leaq	0x40(%rsp), %rax
               	movzbq	0x60(%rsp), %rdx
               	movzbq	0x70(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	movzbq	0x71(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	movzbq	0x72(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	movzbq	0x73(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	movzbq	0x74(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	movzbq	0x75(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	movzbq	0x76(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	movzbq	0x77(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	movzbq	0x78(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	movzbq	0x79(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	movzbq	0x7a(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	movzbq	0x7b(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	movzbq	0x7c(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	movzbq	0x7d(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	movzbq	0x7e(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	movzbq	0x7f(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x4f(%rsp)
               	leaq	0x160(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rdi,%rax), %rdx
               	movzbq	(%r8,%rax), %rsi
               	imulq	%rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x160(%rsp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %r8
               	leaq	0x70(%rsp), %r9
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
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movzbq	(%r8,%rcx), %rax
               	movzbq	(%r9,%rcx), %rdi
               	cltd
               	idivl	%edi
               	andq	$0xff, %rax
               	movb	%al, (%rsi,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	leaq	0x160(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %r9
               	leaq	0x70(%rsp), %rbx
               	leaq	0x40(%rsp), %rcx
               	movzbq	0x60(%rsp), %rsi
               	movzbq	0x70(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rsi
               	movzbq	0x71(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rsi
               	movzbq	0x72(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rsi
               	movzbq	0x73(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rsi
               	movzbq	0x74(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rsi
               	movzbq	0x75(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rsi
               	movzbq	0x76(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rsi
               	movzbq	0x77(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rsi
               	movzbq	0x78(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rsi
               	movzbq	0x79(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rsi
               	movzbq	0x7a(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rsi
               	movzbq	0x7b(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rsi
               	movzbq	0x7c(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rsi
               	movzbq	0x7d(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rsi
               	movzbq	0x7e(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rsi
               	movzbq	0x7f(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movb	%dl, 0x4f(%rsp)
               	leaq	0x160(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	leaq	-0x10(%rbp), %rsi
               	movzbq	(%r9,%rcx), %rdi
               	movzbq	(%rbx,%rcx), %r8
               	movl	%edi, %eax
               	cltd
               	idivl	%r8d
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	leaq	0x160(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	0x70(%rsp), %r8
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	pand	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rdi,%rax), %rdx
               	movzbq	(%r8,%rax), %rsi
               	andq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	0x70(%rsp), %r8
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	por	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rdi,%rax), %rdx
               	movzbq	(%r8,%rax), %rsi
               	orq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	0x70(%rsp), %r8
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	pxor	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rdi,%rax), %rdx
               	movzbq	(%r8,%rax), %rsi
               	xorq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x90(%rsp), %r8
               	movups	0x80(%rsp), %xmm0
               	movups	0x90(%rsp), %xmm1
               	paddb	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movsbq	(%rdi,%rax), %rdx
               	movsbq	(%r8,%rax), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x90(%rsp), %r8
               	movups	0x80(%rsp), %xmm0
               	movups	0x90(%rsp), %xmm1
               	psubb	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movsbq	(%rdi,%rax), %rdx
               	movsbq	(%r8,%rax), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x90(%rsp), %r8
               	leaq	0x40(%rsp), %rax
               	movsbq	0x80(%rsp), %rdx
               	movsbq	0x90(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x40(%rsp)
               	movsbq	0x81(%rsp), %rdx
               	movsbq	0x91(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x41(%rsp)
               	movsbq	0x82(%rsp), %rdx
               	movsbq	0x92(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x42(%rsp)
               	movsbq	0x83(%rsp), %rdx
               	movsbq	0x93(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x43(%rsp)
               	movsbq	0x84(%rsp), %rdx
               	movsbq	0x94(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x44(%rsp)
               	movsbq	0x85(%rsp), %rdx
               	movsbq	0x95(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x45(%rsp)
               	movsbq	0x86(%rsp), %rdx
               	movsbq	0x96(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x46(%rsp)
               	movsbq	0x87(%rsp), %rdx
               	movsbq	0x97(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x47(%rsp)
               	movsbq	0x88(%rsp), %rdx
               	movsbq	0x98(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x48(%rsp)
               	movsbq	0x89(%rsp), %rdx
               	movsbq	0x99(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x49(%rsp)
               	movsbq	0x8a(%rsp), %rdx
               	movsbq	0x9a(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movsbq	0x8b(%rsp), %rdx
               	movsbq	0x9b(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movsbq	0x8c(%rsp), %rdx
               	movsbq	0x9c(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movsbq	0x8d(%rsp), %rdx
               	movsbq	0x9d(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movsbq	0x8e(%rsp), %rdx
               	movsbq	0x9e(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movsbq	0x8f(%rsp), %rdx
               	movsbq	0x9f(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x4f(%rsp)
               	leaq	0x160(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movsbq	(%rdi,%rax), %rdx
               	movsbq	(%r8,%rax), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x160(%rsp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %r8
               	leaq	0x90(%rsp), %r9
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
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movsbq	(%r8,%rcx), %rax
               	movsbq	(%r9,%rcx), %rdi
               	cltd
               	idivl	%edi
               	movb	%al, (%rsi,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	leaq	0x160(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %r9
               	leaq	0x90(%rsp), %rbx
               	leaq	0x40(%rsp), %rcx
               	movsbq	0x80(%rsp), %rsi
               	movsbq	0x90(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x40(%rsp)
               	movsbq	0x81(%rsp), %rsi
               	movsbq	0x91(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x41(%rsp)
               	movsbq	0x82(%rsp), %rsi
               	movsbq	0x92(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x42(%rsp)
               	movsbq	0x83(%rsp), %rsi
               	movsbq	0x93(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x43(%rsp)
               	movsbq	0x84(%rsp), %rsi
               	movsbq	0x94(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x44(%rsp)
               	movsbq	0x85(%rsp), %rsi
               	movsbq	0x95(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x45(%rsp)
               	movsbq	0x86(%rsp), %rsi
               	movsbq	0x96(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x46(%rsp)
               	movsbq	0x87(%rsp), %rsi
               	movsbq	0x97(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x47(%rsp)
               	movsbq	0x88(%rsp), %rsi
               	movsbq	0x98(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x48(%rsp)
               	movsbq	0x89(%rsp), %rsi
               	movsbq	0x99(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x49(%rsp)
               	movsbq	0x8a(%rsp), %rsi
               	movsbq	0x9a(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x4a(%rsp)
               	movsbq	0x8b(%rsp), %rsi
               	movsbq	0x9b(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x4b(%rsp)
               	movsbq	0x8c(%rsp), %rsi
               	movsbq	0x9c(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x4c(%rsp)
               	movsbq	0x8d(%rsp), %rsi
               	movsbq	0x9d(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x4d(%rsp)
               	movsbq	0x8e(%rsp), %rsi
               	movsbq	0x9e(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x4e(%rsp)
               	movsbq	0x8f(%rsp), %rsi
               	movsbq	0x9f(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x4f(%rsp)
               	leaq	0x160(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	leaq	-0x10(%rbp), %rsi
               	movsbq	(%r9,%rcx), %rdi
               	movsbq	(%rbx,%rcx), %r8
               	movl	%edi, %eax
               	cltd
               	idivl	%r8d
               	movb	%dl, (%rsi,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	leaq	0x160(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x90(%rsp), %r8
               	movups	0x80(%rsp), %xmm0
               	movups	0x90(%rsp), %xmm1
               	pand	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movsbq	(%rdi,%rax), %rdx
               	movsbq	(%r8,%rax), %rsi
               	andq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xa0(%rsp), %r8
               	leaq	0xb0(%rsp), %r9
               	movups	0xa0(%rsp), %xmm0
               	movups	0xb0(%rsp), %xmm1
               	paddw	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	%rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movzwq	(%rdi), %rdi
               	addq	%r9, %rcx
               	movzwq	(%rcx), %rcx
               	addq	%rdi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, (%rsi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xa0(%rsp), %r8
               	leaq	0xb0(%rsp), %r9
               	movups	0xa0(%rsp), %xmm0
               	movups	0xb0(%rsp), %xmm1
               	psubw	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	%rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movzwq	(%rdi), %rdi
               	addq	%r9, %rcx
               	movzwq	(%rcx), %rcx
               	subq	%rcx, %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movw	%di, (%rsi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xa0(%rsp), %r8
               	leaq	0xb0(%rsp), %r9
               	movups	0xa0(%rsp), %xmm0
               	movups	0xb0(%rsp), %xmm1
               	pmullw	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	%rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movzwq	(%rdi), %rdi
               	addq	%r9, %rcx
               	movzwq	(%rcx), %rcx
               	imulq	%rdi, %rcx
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	movw	%cx, (%rsi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xa0(%rsp), %r9
               	leaq	0xb0(%rsp), %rbx
               	leaq	0x40(%rsp), %rcx
               	movzwq	0xa0(%rsp), %rax
               	movzwq	0xb0(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movw	%ax, 0x40(%rsp)
               	movzwq	0xa2(%rsp), %rax
               	movzwq	0xb2(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movw	%ax, 0x42(%rsp)
               	movzwq	0xa4(%rsp), %rax
               	movzwq	0xb4(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movw	%ax, 0x44(%rsp)
               	movzwq	0xa6(%rsp), %rax
               	movzwq	0xb6(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movw	%ax, 0x46(%rsp)
               	movzwq	0xa8(%rsp), %rax
               	movzwq	0xb8(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movw	%ax, 0x48(%rsp)
               	movzwq	0xaa(%rsp), %rax
               	movzwq	0xba(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movw	%ax, 0x4a(%rsp)
               	movzwq	0xac(%rsp), %rax
               	movzwq	0xbc(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movw	%ax, 0x4c(%rsp)
               	movzwq	0xae(%rsp), %rax
               	movzwq	0xbe(%rsp), %rdi
               	xorl	%edx, %edx
               	divl	%edi
               	movw	%ax, 0x4e(%rsp)
               	leaq	0x160(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	leaq	(%rsi,%rdx), %rdi
               	leaq	(%r9,%rdx), %rax
               	movzwq	(%rax), %rax
               	addq	%rbx, %rdx
               	movzwq	(%rdx), %r8
               	cltd
               	idivl	%r8d
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, (%rdi)
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	leaq	0x160(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xa0(%rsp), %r9
               	leaq	0xb0(%rsp), %rbx
               	leaq	0x40(%rsp), %rcx
               	movzwq	0xa0(%rsp), %rsi
               	movzwq	0xb0(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movw	%dx, 0x40(%rsp)
               	movzwq	0xa2(%rsp), %rsi
               	movzwq	0xb2(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movw	%dx, 0x42(%rsp)
               	movzwq	0xa4(%rsp), %rsi
               	movzwq	0xb4(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movw	%dx, 0x44(%rsp)
               	movzwq	0xa6(%rsp), %rsi
               	movzwq	0xb6(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movw	%dx, 0x46(%rsp)
               	movzwq	0xa8(%rsp), %rsi
               	movzwq	0xb8(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movw	%dx, 0x48(%rsp)
               	movzwq	0xaa(%rsp), %rsi
               	movzwq	0xba(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movw	%dx, 0x4a(%rsp)
               	movzwq	0xac(%rsp), %rsi
               	movzwq	0xbc(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movw	%dx, 0x4c(%rsp)
               	movzwq	0xae(%rsp), %rsi
               	movzwq	0xbe(%rsp), %rdi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movw	%dx, 0x4e(%rsp)
               	leaq	0x160(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	leaq	-0x10(%rbp), %rax
               	movq	%rcx, %rdx
               	shlq	%rdx
               	leaq	(%rax,%rdx), %rsi
               	leaq	(%r9,%rdx), %rax
               	movzwq	(%rax), %rdi
               	leaq	(%rbx,%rdx), %rax
               	movzwq	(%rax), %r8
               	movl	%edi, %eax
               	cltd
               	idivl	%r8d
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, (%rsi)
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	leaq	0x160(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xc0(%rsp), %r8
               	leaq	0xd0(%rsp), %r9
               	movups	0xc0(%rsp), %xmm0
               	movups	0xd0(%rsp), %xmm1
               	paddw	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	%rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movswq	(%rdi), %rdi
               	addq	%r9, %rcx
               	movswq	(%rcx), %rcx
               	addq	%rdi, %rcx
               	movw	%cx, (%rsi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xc0(%rsp), %r8
               	leaq	0xd0(%rsp), %r9
               	movups	0xc0(%rsp), %xmm0
               	movups	0xd0(%rsp), %xmm1
               	psubw	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	%rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movswq	(%rdi), %rdi
               	addq	%r9, %rcx
               	movswq	(%rcx), %rcx
               	subq	%rcx, %rdi
               	movw	%di, (%rsi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xc0(%rsp), %r8
               	leaq	0xd0(%rsp), %r9
               	movups	0xc0(%rsp), %xmm0
               	movups	0xd0(%rsp), %xmm1
               	pmullw	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	%rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movswq	(%rdi), %rdi
               	addq	%r9, %rcx
               	movswq	(%rcx), %rcx
               	imulq	%rdi, %rcx
               	movw	%cx, (%rsi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xc0(%rsp), %r9
               	leaq	0xd0(%rsp), %rbx
               	leaq	0x40(%rsp), %rcx
               	movswq	0xc0(%rsp), %rax
               	movswq	0xd0(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movw	%ax, 0x40(%rsp)
               	movswq	0xc2(%rsp), %rax
               	movswq	0xd2(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movw	%ax, 0x42(%rsp)
               	movswq	0xc4(%rsp), %rax
               	movswq	0xd4(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movw	%ax, 0x44(%rsp)
               	movswq	0xc6(%rsp), %rax
               	movswq	0xd6(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movw	%ax, 0x46(%rsp)
               	movswq	0xc8(%rsp), %rax
               	movswq	0xd8(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movw	%ax, 0x48(%rsp)
               	movswq	0xca(%rsp), %rax
               	movswq	0xda(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movw	%ax, 0x4a(%rsp)
               	movswq	0xcc(%rsp), %rax
               	movswq	0xdc(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movw	%ax, 0x4c(%rsp)
               	movswq	0xce(%rsp), %rax
               	movswq	0xde(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movw	%ax, 0x4e(%rsp)
               	leaq	0x160(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	leaq	(%rsi,%rdx), %rdi
               	leaq	(%r9,%rdx), %rax
               	movswq	(%rax), %rax
               	addq	%rbx, %rdx
               	movswq	(%rdx), %r8
               	cltd
               	idivl	%r8d
               	movw	%ax, (%rdi)
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	leaq	0x160(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xc0(%rsp), %r9
               	leaq	0xd0(%rsp), %rbx
               	leaq	0x40(%rsp), %rcx
               	movswq	0xc0(%rsp), %rsi
               	movswq	0xd0(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movw	%dx, 0x40(%rsp)
               	movswq	0xc2(%rsp), %rsi
               	movswq	0xd2(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movw	%dx, 0x42(%rsp)
               	movswq	0xc4(%rsp), %rsi
               	movswq	0xd4(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movw	%dx, 0x44(%rsp)
               	movswq	0xc6(%rsp), %rsi
               	movswq	0xd6(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movw	%dx, 0x46(%rsp)
               	movswq	0xc8(%rsp), %rsi
               	movswq	0xd8(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movw	%dx, 0x48(%rsp)
               	movswq	0xca(%rsp), %rsi
               	movswq	0xda(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movw	%dx, 0x4a(%rsp)
               	movswq	0xcc(%rsp), %rsi
               	movswq	0xdc(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movw	%dx, 0x4c(%rsp)
               	movswq	0xce(%rsp), %rsi
               	movswq	0xde(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movw	%dx, 0x4e(%rsp)
               	leaq	0x160(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	leaq	-0x10(%rbp), %rax
               	movq	%rcx, %rdx
               	shlq	%rdx
               	leaq	(%rax,%rdx), %rsi
               	leaq	(%r9,%rdx), %rax
               	movswq	(%rax), %rdi
               	leaq	(%rbx,%rdx), %rax
               	movswq	(%rax), %r8
               	movl	%edi, %eax
               	cltd
               	idivl	%r8d
               	movw	%dx, (%rsi)
               	incq	%rcx
               	cmpl	$0x8, %ecx
               	jl	<addr>
               	leaq	0x160(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xe0(%rsp), %r8
               	leaq	0xf0(%rsp), %r9
               	movups	0xe0(%rsp), %xmm0
               	movups	0xf0(%rsp), %xmm1
               	paddd	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movl	(%rdi), %edi
               	addq	%r9, %rcx
               	movl	(%rcx), %ecx
               	addq	%rdi, %rcx
               	movl	%ecx, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xe0(%rsp), %r8
               	leaq	0xf0(%rsp), %r9
               	movups	0xe0(%rsp), %xmm0
               	movups	0xf0(%rsp), %xmm1
               	psubd	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movl	(%rdi), %edi
               	addq	%r9, %rcx
               	movl	(%rcx), %ecx
               	subq	%rcx, %rdi
               	movl	%edi, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xe0(%rsp), %rdi
               	leaq	0xf0(%rsp), %r8
               	movl	0xe0(%rsp), %eax
               	movl	0xf0(%rsp), %ecx
               	imulq	%rcx, %rax
               	movl	0xe4(%rsp), %ecx
               	movl	0xf4(%rsp), %edx
               	imulq	%rdx, %rcx
               	movl	0xe8(%rsp), %edx
               	movl	0xf8(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	0xec(%rsp), %esi
               	movl	0xfc(%rsp), %r9d
               	imulq	%r9, %rsi
               	movl	%eax, 0x40(%rsp)
               	movl	%ecx, 0x44(%rsp)
               	movl	%edx, 0x48(%rsp)
               	movl	%esi, 0x4c(%rsp)
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rdi,%rcx), %rsi
               	movl	(%rsi), %esi
               	addq	%r8, %rcx
               	movl	(%rcx), %ecx
               	imulq	%rsi, %rcx
               	movl	%ecx, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xe0(%rsp), %r8
               	leaq	0xf0(%rsp), %r9
               	movl	0xe0(%rsp), %eax
               	movl	0xf0(%rsp), %ecx
               	xorl	%edx, %edx
               	divl	%ecx
               	movq	%rax, %rcx
               	movl	0xe4(%rsp), %eax
               	movl	0xf4(%rsp), %esi
               	xorl	%edx, %edx
               	divl	%esi
               	movq	%rax, %rsi
               	movl	0xe8(%rsp), %eax
               	movl	0xf8(%rsp), %edi
               	xorl	%edx, %edx
               	divl	%edi
               	movq	%rax, %rdi
               	movl	0xec(%rsp), %eax
               	movl	0xfc(%rsp), %edx
               	movq	%rdx, %r10
               	xorl	%edx, %edx
               	divl	%r10d
               	movl	%ecx, 0x40(%rsp)
               	movl	%esi, 0x44(%rsp)
               	movl	%edi, 0x48(%rsp)
               	movl	%eax, 0x4c(%rsp)
               	xorl	%ecx, %ecx
               	leaq	-0x10(%rbp), %rax
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rax,%rdx), %rsi
               	leaq	(%r8,%rdx), %rax
               	movl	(%rax), %eax
               	addq	%r9, %rdx
               	movl	(%rdx), %edi
               	xorl	%edx, %edx
               	divl	%edi
               	movl	%eax, (%rsi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xe0(%rsp), %r9
               	movl	0xe0(%rsp), %ecx
               	movl	0xf0(%rsp), %esi
               	movl	%ecx, %eax
               	xorl	%edx, %edx
               	divl	%esi
               	movq	%rdx, %rcx
               	movl	0xe4(%rsp), %esi
               	movl	0xf4(%rsp), %edi
               	movl	%esi, %eax
               	xorl	%edx, %edx
               	divl	%edi
               	movq	%rdx, %rsi
               	movl	0xe8(%rsp), %edi
               	movl	0xf8(%rsp), %r8d
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movq	%rdx, %rdi
               	movl	0xec(%rsp), %r8d
               	movl	0xfc(%rsp), %eax
               	movq	%rax, %r10
               	movl	%r8d, %eax
               	xorl	%edx, %edx
               	divl	%r10d
               	movl	%ecx, 0x40(%rsp)
               	movl	%esi, 0x44(%rsp)
               	movl	%edi, 0x48(%rsp)
               	movl	%edx, 0x4c(%rsp)
               	leaq	0xf0(%rsp), %rbx
               	xorl	%ecx, %ecx
               	leaq	-0x10(%rbp), %rax
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rax,%rdx), %rsi
               	leaq	(%r9,%rdx), %rax
               	movl	(%rax), %edi
               	leaq	(%rbx,%rdx), %rax
               	movl	(%rax), %r8d
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movl	%edx, (%rsi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %r8
               	leaq	0x110(%rsp), %r9
               	movups	0x100(%rsp), %xmm0
               	movups	0x110(%rsp), %xmm1
               	paddd	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movl	(%rdi), %edi
               	addq	%r9, %rcx
               	movl	(%rcx), %ecx
               	addq	%rdi, %rcx
               	movl	%ecx, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %r8
               	leaq	0x110(%rsp), %r9
               	movups	0x100(%rsp), %xmm0
               	movups	0x110(%rsp), %xmm1
               	psubd	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movl	(%rdi), %edi
               	addq	%r9, %rcx
               	movl	(%rcx), %ecx
               	subq	%rcx, %rdi
               	movl	%edi, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %rdi
               	leaq	0x110(%rsp), %r8
               	movl	0x100(%rsp), %eax
               	movl	0x110(%rsp), %ecx
               	imulq	%rcx, %rax
               	movl	0x104(%rsp), %ecx
               	movl	0x114(%rsp), %edx
               	imulq	%rdx, %rcx
               	movl	0x108(%rsp), %edx
               	movl	0x118(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	0x10c(%rsp), %esi
               	movl	0x11c(%rsp), %r9d
               	imulq	%r9, %rsi
               	movl	%eax, 0x40(%rsp)
               	movl	%ecx, 0x44(%rsp)
               	movl	%edx, 0x48(%rsp)
               	movl	%esi, 0x4c(%rsp)
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rdi,%rcx), %rsi
               	movl	(%rsi), %esi
               	addq	%r8, %rcx
               	movl	(%rcx), %ecx
               	imulq	%rsi, %rcx
               	movl	%ecx, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %r8
               	leaq	0x110(%rsp), %r9
               	movslq	0x100(%rsp), %rax
               	movslq	0x110(%rsp), %rcx
               	cqto
               	idivq	%rcx
               	movq	%rax, %rcx
               	movslq	0x104(%rsp), %rax
               	movslq	0x114(%rsp), %rsi
               	cqto
               	idivq	%rsi
               	movq	%rax, %rsi
               	movslq	0x108(%rsp), %rax
               	movslq	0x118(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	movslq	0x10c(%rsp), %rax
               	movslq	0x11c(%rsp), %rdx
               	movq	%rdx, %r10
               	cqto
               	idivq	%r10
               	movl	%ecx, 0x40(%rsp)
               	movl	%esi, 0x44(%rsp)
               	movl	%edi, 0x48(%rsp)
               	movl	%eax, 0x4c(%rsp)
               	xorl	%ecx, %ecx
               	leaq	-0x10(%rbp), %rax
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rax,%rdx), %rsi
               	leaq	(%r8,%rdx), %rax
               	movl	(%rax), %eax
               	addq	%r9, %rdx
               	movl	(%rdx), %edi
               	cltd
               	idivl	%edi
               	movl	%eax, (%rsi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %r9
               	movslq	0x100(%rsp), %rcx
               	movslq	0x110(%rsp), %rsi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rsi
               	movq	%rdx, %rcx
               	movslq	0x104(%rsp), %rsi
               	movslq	0x114(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movq	%rdx, %rsi
               	movslq	0x108(%rsp), %rdi
               	movslq	0x118(%rsp), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rdx, %rdi
               	movslq	0x10c(%rsp), %r8
               	movslq	0x11c(%rsp), %rax
               	movq	%rax, %r10
               	movq	%r8, %rax
               	cqto
               	idivq	%r10
               	movl	%ecx, 0x40(%rsp)
               	movl	%esi, 0x44(%rsp)
               	movl	%edi, 0x48(%rsp)
               	movl	%edx, 0x4c(%rsp)
               	leaq	0x110(%rsp), %rbx
               	xorl	%ecx, %ecx
               	leaq	-0x10(%rbp), %rax
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rax,%rdx), %rsi
               	leaq	(%r9,%rdx), %rax
               	movl	(%rax), %edi
               	leaq	(%rbx,%rdx), %rax
               	movl	(%rax), %r8d
               	movl	%edi, %eax
               	cltd
               	idivl	%r8d
               	movl	%edx, (%rsi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x120(%rsp), %r8
               	leaq	0x130(%rsp), %r9
               	movups	0x120(%rsp), %xmm0
               	movups	0x130(%rsp), %xmm1
               	paddq	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movq	(%rdi), %rdi
               	addq	%r9, %rcx
               	movq	(%rcx), %rcx
               	addq	%rdi, %rcx
               	movq	%rcx, (%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x120(%rsp), %r8
               	leaq	0x130(%rsp), %r9
               	movups	0x120(%rsp), %xmm0
               	movups	0x130(%rsp), %xmm1
               	psubq	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movq	(%rdi), %rdi
               	addq	%r9, %rcx
               	movq	(%rcx), %rcx
               	subq	%rcx, %rdi
               	movq	%rdi, (%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x120(%rsp), %r8
               	leaq	0x130(%rsp), %r9
               	movq	0x120(%rsp), %rax
               	movq	0x130(%rsp), %rcx
               	imulq	%rcx, %rax
               	movq	0x128(%rsp), %rcx
               	movq	0x138(%rsp), %rsi
               	imulq	%rsi, %rcx
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movq	(%rdi), %rdi
               	addq	%r9, %rcx
               	movq	(%rcx), %rcx
               	imulq	%rdi, %rcx
               	movq	%rcx, (%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x120(%rsp), %r9
               	leaq	0x130(%rsp), %rbx
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
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rsi,%rdx), %rdi
               	leaq	(%r9,%rdx), %rax
               	movq	(%rax), %rax
               	addq	%rbx, %rdx
               	movq	(%rdx), %r8
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rax, (%rdi)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x120(%rsp), %rbx
               	leaq	0x130(%rsp), %r12
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
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rsi,%rdx), %rdi
               	leaq	(%rbx,%rdx), %rax
               	movq	(%rax), %r8
               	leaq	(%r12,%rdx), %rax
               	movq	(%rax), %r9
               	movq	%r8, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movq	%rdx, (%rdi)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %r8
               	leaq	0x150(%rsp), %r9
               	movups	0x140(%rsp), %xmm0
               	movups	0x150(%rsp), %xmm1
               	paddq	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movq	(%rdi), %rdi
               	addq	%r9, %rcx
               	movq	(%rcx), %rcx
               	addq	%rdi, %rcx
               	movq	%rcx, (%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %r8
               	leaq	0x150(%rsp), %r9
               	movups	0x140(%rsp), %xmm0
               	movups	0x150(%rsp), %xmm1
               	psubq	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movq	(%rdi), %rdi
               	addq	%r9, %rcx
               	movq	(%rcx), %rcx
               	subq	%rcx, %rdi
               	movq	%rdi, (%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %r8
               	leaq	0x150(%rsp), %r9
               	movq	0x140(%rsp), %rax
               	movq	0x150(%rsp), %rcx
               	imulq	%rcx, %rax
               	movq	0x148(%rsp), %rcx
               	movq	0x158(%rsp), %rsi
               	imulq	%rsi, %rcx
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movq	(%rdi), %rdi
               	addq	%r9, %rcx
               	movq	(%rcx), %rcx
               	imulq	%rdi, %rcx
               	movq	%rcx, (%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %r9
               	leaq	0x150(%rsp), %rbx
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
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rsi,%rdx), %rdi
               	leaq	(%r9,%rdx), %rax
               	movq	(%rax), %rax
               	addq	%rbx, %rdx
               	movq	(%rdx), %r8
               	cqto
               	idivq	%r8
               	movq	%rax, (%rdi)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %rbx
               	leaq	0x150(%rsp), %r12
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
               	movq	%rcx, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rsi,%rdx), %rdi
               	leaq	(%rbx,%rdx), %rax
               	movq	(%rax), %r8
               	leaq	(%r12,%rdx), %rax
               	movq	(%rax), %r9
               	movq	%r8, %rax
               	cqto
               	idivq	%r9
               	movq	%rdx, (%rdi)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x30(%rbp), %r8
               	movsd	-0x38(%rbp), %xmm0
               	movsd	-0x30(%rbp), %xmm1
               	paddb	%xmm1, %xmm0
               	movsd	%xmm0, -0x28(%rbp)
               	xorl	%eax, %eax
               	leaq	-0x8(%rbp), %rcx
               	movzbq	(%rdi,%rax), %rdx
               	movzbq	(%r8,%rax), %rsi
               	addq	%rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x8(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x30(%rbp), %r8
               	leaq	-0x8(%rbp), %rax
               	movzbq	-0x38(%rbp), %rcx
               	movzbq	-0x30(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x37(%rbp), %rcx
               	movzbq	-0x2f(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, -0x7(%rbp)
               	movzbq	-0x36(%rbp), %rcx
               	movzbq	-0x2e(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, -0x6(%rbp)
               	movzbq	-0x35(%rbp), %rcx
               	movzbq	-0x2d(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, -0x5(%rbp)
               	movzbq	-0x34(%rbp), %rcx
               	movzbq	-0x2c(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, -0x4(%rbp)
               	movzbq	-0x33(%rbp), %rcx
               	movzbq	-0x2b(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, -0x3(%rbp)
               	movzbq	-0x32(%rbp), %rcx
               	movzbq	-0x2a(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, -0x2(%rbp)
               	movzbq	-0x31(%rbp), %rcx
               	movzbq	-0x29(%rbp), %rdx
               	imulq	%rdx, %rcx
               	movb	%cl, -0x1(%rbp)
               	leaq	-0x28(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	xorl	%eax, %eax
               	leaq	-0x8(%rbp), %rcx
               	movzbq	(%rdi,%rax), %rdx
               	movzbq	(%r8,%rax), %rsi
               	imulq	%rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x28(%rbp), %rcx
               	leaq	-0x8(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	(%rsp), %rdi
               	leaq	0x20(%rsp), %r8
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vpaddd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	leaq	-0x20(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rdi,%rcx), %rsi
               	movl	(%rsi), %esi
               	addq	%r8, %rcx
               	movl	(%rcx), %ecx
               	addq	%rsi, %rcx
               	movl	%ecx, (%rdx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	(%rsp), %r8
               	leaq	0x20(%rsp), %r9
               	vmovups	(%rsp), %ymm0
               	vmovups	0x20(%rsp), %ymm1
               	vpsubd	%ymm1, %ymm0, %ymm0
               	vmovups	%ymm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movl	(%rdi), %edi
               	addq	%r9, %rcx
               	movl	(%rcx), %ecx
               	subq	%rcx, %rdi
               	movl	%edi, (%rsi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x20(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	0x160(%rsp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x60(%rsp), %r8
               	leaq	0x40(%rsp), %rax
               	movzbq	0x60(%rsp), %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	shlq	%rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	shlq	$0x4, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	shlq	$0x5, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	shlq	$0x6, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	shlq	$0x7, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	shlq	%rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	shlq	$0x4, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	shlq	$0x5, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	shlq	$0x6, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	shlq	$0x7, %rdx
               	movb	%dl, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rdx
               	movzbq	(%r8,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	0x160(%rsp), %r8
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
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rdi,%rax), %rdx
               	movzbq	(%r8,%rax), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xc0(%rsp), %r8
               	leaq	(%rsp), %r9
               	leaq	0x40(%rsp), %rax
               	movswq	0xc0(%rsp), %rcx
               	movswq	(%rsp), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x40(%rsp)
               	movswq	0xc2(%rsp), %rcx
               	movswq	0x2(%rsp), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x42(%rsp)
               	movswq	0xc4(%rsp), %rcx
               	movswq	0x4(%rsp), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x44(%rsp)
               	movswq	0xc6(%rsp), %rcx
               	movswq	0x6(%rsp), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x46(%rsp)
               	movswq	0xc8(%rsp), %rcx
               	movswq	0x8(%rsp), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x48(%rsp)
               	movswq	0xca(%rsp), %rcx
               	movswq	0xa(%rsp), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x4a(%rsp)
               	movswq	0xcc(%rsp), %rcx
               	movswq	0xc(%rsp), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x4c(%rsp)
               	movswq	0xce(%rsp), %rcx
               	movswq	0xe(%rsp), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x4e(%rsp)
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	%rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movswq	(%rdi), %rdi
               	addq	%r9, %rcx
               	movswq	(%rcx), %rcx
               	sarxq	%rcx, %rdi, %rcx
               	movw	%cx, (%rsi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xc0(%rsp), %r8
               	leaq	(%rsp), %r9
               	leaq	0x40(%rsp), %rax
               	movswq	0xc0(%rsp), %rcx
               	movswq	(%rsp), %rsi
               	shlxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x40(%rsp)
               	movswq	0xc2(%rsp), %rcx
               	movswq	0x2(%rsp), %rsi
               	shlxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x42(%rsp)
               	movswq	0xc4(%rsp), %rcx
               	movswq	0x4(%rsp), %rsi
               	shlxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x44(%rsp)
               	movswq	0xc6(%rsp), %rcx
               	movswq	0x6(%rsp), %rsi
               	shlxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x46(%rsp)
               	movswq	0xc8(%rsp), %rcx
               	movswq	0x8(%rsp), %rsi
               	shlxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x48(%rsp)
               	movswq	0xca(%rsp), %rcx
               	movswq	0xa(%rsp), %rsi
               	shlxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x4a(%rsp)
               	movswq	0xcc(%rsp), %rcx
               	movswq	0xc(%rsp), %rsi
               	shlxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x4c(%rsp)
               	movswq	0xce(%rsp), %rcx
               	movswq	0xe(%rsp), %rsi
               	shlxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x4e(%rsp)
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	%rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movswq	(%rdi), %rdi
               	addq	%r9, %rcx
               	movswq	(%rcx), %rcx
               	shlxq	%rcx, %rdi, %rcx
               	movw	%cx, (%rsi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %rdi
               	movslq	0x100(%rsp), %rax
               	sarq	$0x3, %rax
               	movslq	0x104(%rsp), %rdx
               	sarq	$0x3, %rdx
               	movslq	0x108(%rsp), %rsi
               	sarq	$0x3, %rsi
               	movslq	0x10c(%rsp), %r8
               	sarq	$0x3, %r8
               	movl	%eax, 0x40(%rsp)
               	movl	%edx, 0x44(%rsp)
               	movl	%esi, 0x48(%rsp)
               	movl	%r8d, 0x4c(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	addq	%rdi, %rdx
               	movslq	(%rdx), %rdx
               	sarq	$0x3, %rdx
               	movl	%edx, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xe0(%rsp), %rdi
               	movl	0xe0(%rsp), %eax
               	shrq	$0x3, %rax
               	movl	0xe4(%rsp), %edx
               	shrq	$0x3, %rdx
               	movl	0xe8(%rsp), %esi
               	shrq	$0x3, %rsi
               	movl	0xec(%rsp), %r8d
               	shrq	$0x3, %r8
               	movl	%eax, 0x40(%rsp)
               	movl	%edx, 0x44(%rsp)
               	movl	%esi, 0x48(%rsp)
               	movl	%r8d, 0x4c(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	addq	%rdi, %rdx
               	movl	(%rdx), %edx
               	shrq	$0x3, %rdx
               	movl	%edx, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rsi
               	leaq	0x40(%rsp), %rax
               	movsbq	0x80(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x40(%rsp)
               	movsbq	0x81(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x41(%rsp)
               	movsbq	0x82(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x42(%rsp)
               	movsbq	0x83(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x43(%rsp)
               	movsbq	0x84(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x44(%rsp)
               	movsbq	0x85(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x45(%rsp)
               	movsbq	0x86(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x46(%rsp)
               	movsbq	0x87(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x47(%rsp)
               	movsbq	0x88(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x48(%rsp)
               	movsbq	0x89(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x49(%rsp)
               	movsbq	0x8a(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movsbq	0x8b(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movsbq	0x8c(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movsbq	0x8d(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movsbq	0x8e(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movsbq	0x8f(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rsi
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
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rsi,%rax), %rdx
               	subq	$0x40, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rsi
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
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rsi,%rax), %rdx
               	addq	$0x64, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rsi
               	movl	$0x7, %eax
               	leaq	0x40(%rsp), %rdx
               	movzbq	0x60(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdi
               	imulq	%rdi, %rax
               	movb	%al, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movzbq	(%rsi,%rax), %rdx
               	imulq	$0x7, %rdx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rsi
               	leaq	0x40(%rsp), %rax
               	movzbq	0x60(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rsi,%rax), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	0x40(%rsp), %rdx
               	movzbq	0x60(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movzbq	(%rdi,%rax), %rdx
               	imulq	$0x24924925, %rdx, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rsi
               	movl	$0xf, %eax
               	leaq	0x40(%rsp), %rdx
               	movzbq	0x60(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdi
               	andq	%rdi, %rax
               	movb	%al, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movzbq	(%rsi,%rax), %rdx
               	andq	$0xf, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rsi
               	movl	$0xf0, %eax
               	leaq	0x40(%rsp), %rdx
               	movzbq	0x60(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdi
               	orq	%rdi, %rax
               	movb	%al, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movzbq	(%rsi,%rax), %rdx
               	orq	$0xf0, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rsi
               	movl	$0x55, %eax
               	leaq	0x40(%rsp), %rdx
               	movzbq	0x60(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdi
               	xorq	%rdi, %rax
               	movb	%al, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movzbq	(%rsi,%rax), %rdx
               	xorq	$0x55, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rsi
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
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rdi
               	leaq	0x40(%rsp), %rdx
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
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movsbq	(%rdi,%rax), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %r8
               	leaq	0x40(%rsp), %rsi
               	movsbq	0x80(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x40(%rsp)
               	movsbq	0x81(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x41(%rsp)
               	movsbq	0x82(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x42(%rsp)
               	movsbq	0x83(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x43(%rsp)
               	movsbq	0x84(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x44(%rsp)
               	movsbq	0x85(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x45(%rsp)
               	movsbq	0x86(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x46(%rsp)
               	movsbq	0x87(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x47(%rsp)
               	movsbq	0x88(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x48(%rsp)
               	movsbq	0x89(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x49(%rsp)
               	movsbq	0x8a(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x4a(%rsp)
               	movsbq	0x8b(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x4b(%rsp)
               	movsbq	0x8c(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x4c(%rsp)
               	movsbq	0x8d(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x4d(%rsp)
               	movsbq	0x8e(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x4e(%rsp)
               	movsbq	0x8f(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movsbq	(%r8,%rax), %rdx
               	imulq	$0x55555556, %rdx, %rsi # imm = 0x55555556
               	sarq	$0x20, %rsi
               	movq	%rsi, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xa0(%rsp), %rdi
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	leaq	0x40(%rsp), %rdx
               	movzwq	0xa0(%rsp), %rsi
               	imulq	%rax, %rsi
               	movw	%si, 0x40(%rsp)
               	movzwq	0xa2(%rsp), %rsi
               	imulq	%rax, %rsi
               	movw	%si, 0x42(%rsp)
               	movzwq	0xa4(%rsp), %rsi
               	imulq	%rax, %rsi
               	movw	%si, 0x44(%rsp)
               	movzwq	0xa6(%rsp), %rsi
               	imulq	%rax, %rsi
               	movw	%si, 0x46(%rsp)
               	movzwq	0xa8(%rsp), %rsi
               	imulq	%rax, %rsi
               	movw	%si, 0x48(%rsp)
               	movzwq	0xaa(%rsp), %rsi
               	imulq	%rax, %rsi
               	movw	%si, 0x4a(%rsp)
               	movzwq	0xac(%rsp), %rsi
               	imulq	%rax, %rsi
               	movw	%si, 0x4c(%rsp)
               	movzwq	0xae(%rsp), %rsi
               	imulq	%rsi, %rax
               	movw	%ax, 0x4e(%rsp)
               	leaq	0x20(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	%rdx
               	leaq	(%rcx,%rdx), %rsi
               	addq	%rdi, %rdx
               	movzwq	(%rdx), %rdx
               	imulq	$0x3e8, %rdx, %rdx      # imm = 0x3E8
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	movw	%dx, (%rsi)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %rdi
               	movl	$0x7, %eax
               	movq	0x140(%rsp), %rdx
               	imulq	%rax, %rdx
               	movq	0x148(%rsp), %rsi
               	imulq	%rsi, %rax
               	movq	%rdx, 0x40(%rsp)
               	movq	%rax, 0x48(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	imulq	$0x7, %rdx, %rdx
               	movq	%rdx, (%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x40, %eax
               	leaq	0x60(%rsp), %rdi
               	leaq	0x40(%rsp), %rdx
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
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movl	$0x40, %edx
               	movzbq	(%rdi,%rax), %rsi
               	subq	%rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x64, %eax
               	leaq	0x80(%rsp), %rdi
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
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movl	$0x64, %edx
               	movsbq	(%rdi,%rax), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0xfa, %ecx
               	leaq	0x70(%rsp), %r8
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
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xfa, %eax
               	movzbq	(%r8,%rcx), %rdi
               	cltd
               	idivl	%edi
               	andq	$0xff, %rax
               	movb	%al, (%rsi,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	leaq	0x20(%rsp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0xfa, %ecx
               	leaq	0x70(%rsp), %r9
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
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xfa, %edi
               	movzbq	(%r9,%rcx), %r8
               	movl	%edi, %eax
               	cltd
               	idivl	%r8d
               	andq	$0xff, %rdx
               	movb	%dl, (%rsi,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0xf, %eax
               	leaq	0x70(%rsp), %rsi
               	leaq	0x40(%rsp), %rdx
               	movzbq	0x70(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x40(%rsp)
               	movzbq	0x71(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x41(%rsp)
               	movzbq	0x72(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x42(%rsp)
               	movzbq	0x73(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x43(%rsp)
               	movzbq	0x74(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x44(%rsp)
               	movzbq	0x75(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x45(%rsp)
               	movzbq	0x76(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x46(%rsp)
               	movzbq	0x77(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x47(%rsp)
               	movzbq	0x78(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x48(%rsp)
               	movzbq	0x79(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x49(%rsp)
               	movzbq	0x7a(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x4a(%rsp)
               	movzbq	0x7b(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x4b(%rsp)
               	movzbq	0x7c(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x4c(%rsp)
               	movzbq	0x7d(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x4d(%rsp)
               	movzbq	0x7e(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x4e(%rsp)
               	movzbq	0x7f(%rsp), %rdi
               	andq	%rdi, %rax
               	movb	%al, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movzbq	(%rsi,%rax), %rdx
               	andq	$0xf, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x3, %eax
               	leaq	0x160(%rsp), %rdi
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
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movl	$0x3, %edx
               	movzbq	(%rdi,%rax), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x80, %eax
               	leaq	0x160(%rsp), %rdi
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
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movl	$0x80, %edx
               	movzbq	(%rdi,%rax), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	$-0x7, %rcx
               	leaq	0x110(%rsp), %r9
               	movslq	0x110(%rsp), %rdi
               	movq	%rcx, %rax
               	cqto
               	idivq	%rdi
               	movq	%rax, %rdi
               	movslq	0x114(%rsp), %r8
               	movq	%rcx, %rax
               	cqto
               	idivq	%r8
               	movq	%rax, %r8
               	movslq	0x118(%rsp), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movslq	0x11c(%rsp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %rcx
               	popq	%rax
               	movl	%edi, 0x40(%rsp)
               	movl	%r8d, 0x44(%rsp)
               	movl	%eax, 0x48(%rsp)
               	movl	%ecx, 0x4c(%rsp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rsi,%rdx), %rdi
               	movq	$-0x7, %rax
               	addq	%r9, %rdx
               	movl	(%rdx), %r8d
               	cltd
               	idivl	%r8d
               	movl	%eax, (%rdi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	$-0x7, %rcx
               	leaq	0x110(%rsp), %rbx
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
               	movslq	0x118(%rsp), %r9
               	movq	%rcx, %rax
               	cqto
               	idivq	%r9
               	movq	%rdx, %r9
               	movslq	0x11c(%rsp), %rax
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movl	%edi, 0x40(%rsp)
               	movl	%r8d, 0x44(%rsp)
               	movl	%r9d, 0x48(%rsp)
               	movl	%edx, 0x4c(%rsp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rsi,%rdx), %rdi
               	movq	$-0x7, %r8
               	leaq	(%rbx,%rdx), %rax
               	movl	(%rax), %r9d
               	movl	%r8d, %eax
               	cltd
               	idivl	%r9d
               	movl	%edx, (%rdi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
               	jl	<addr>
               	leaq	0x40(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rsi
               	leaq	0x40(%rsp), %rax
               	movzbq	0x60(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rsi,%rax), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %r8
               	movslq	0x100(%rsp), %rax
               	movl	$0x92492493, %r11d      # imm = 0x92492493
               	imulq	%r11, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rax, %rdx
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
               	movq	%rax, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rax, %rdi
               	movslq	0x10c(%rsp), %rax
               	movl	$0x92492493, %r11d      # imm = 0x92492493
               	imulq	%r11, %rax
               	sarq	$0x22, %rax
               	movq	%rax, %r9
               	shrq	$0x3f, %r9
               	addq	%r9, %rax
               	movl	%edx, 0x40(%rsp)
               	movl	%esi, 0x44(%rsp)
               	movl	%edi, 0x48(%rsp)
               	movl	%eax, 0x4c(%rsp)
               	xorl	%eax, %eax
               	movl	$0x92492493, %r9d       # imm = 0x92492493
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	addq	%r8, %rdx
               	movslq	(%rdx), %rdx
               	imulq	%r9, %rdx
               	sarq	$0x22, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	movl	%edx, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rsi
               	leaq	0x40(%rsp), %rdx
               	movzbq	0x60(%rsp), %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rdi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rdi)
               	movzbq	(%rsi,%rax), %rdx
               	negq	%rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rsi
               	leaq	0x40(%rsp), %rdx
               	movsbq	0x80(%rsp), %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, 0x40(%rsp)
               	movsbq	0x81(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x41(%rsp)
               	movsbq	0x82(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x42(%rsp)
               	movsbq	0x83(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x43(%rsp)
               	movsbq	0x84(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x44(%rsp)
               	movsbq	0x85(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x45(%rsp)
               	movsbq	0x86(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x46(%rsp)
               	movsbq	0x87(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x47(%rsp)
               	movsbq	0x88(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x48(%rsp)
               	movsbq	0x89(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x49(%rsp)
               	movsbq	0x8a(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x4a(%rsp)
               	movsbq	0x8b(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x4b(%rsp)
               	movsbq	0x8c(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x4c(%rsp)
               	movsbq	0x8d(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x4d(%rsp)
               	movsbq	0x8e(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x4e(%rsp)
               	movsbq	0x8f(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rdi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rdi)
               	movsbq	(%rsi,%rax), %rdx
               	negq	%rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %rdi
               	movl	0x100(%rsp), %edx
               	xorl	%eax, %eax
               	negq	%rdx
               	movl	0x104(%rsp), %esi
               	negq	%rsi
               	movl	0x108(%rsp), %r8d
               	negq	%r8
               	movl	0x10c(%rsp), %r9d
               	negq	%r9
               	movl	%edx, 0x40(%rsp)
               	movl	%esi, 0x44(%rsp)
               	movl	%r8d, 0x48(%rsp)
               	movl	%r9d, 0x4c(%rsp)
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	addq	%rdi, %rdx
               	movl	(%rdx), %edx
               	negq	%rdx
               	movl	%edx, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rsi
               	leaq	0x40(%rsp), %rax
               	movzbq	0x60(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rsi,%rax), %rdx
               	xorq	$-0x1, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %rdi
               	movq	0x140(%rsp), %rax
               	xorq	$-0x1, %rax
               	movq	0x148(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movq	%rax, 0x40(%rsp)
               	movq	%rdx, 0x48(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rdx
               	shlq	$0x3, %rdx
               	leaq	(%rcx,%rdx), %rsi
               	addq	%rdi, %rdx
               	movq	(%rdx), %rdx
               	xorq	$-0x1, %rdx
               	movq	%rdx, (%rsi)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	paddb	%xmm1, %xmm0
               	leaq	0x20(%rsp), %rdx
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x40(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	paddb	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	psubb	%xmm1, %xmm0
               	leaq	0x20(%rsp), %rdx
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x40(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	psubb	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movzbq	0x60(%rsp), %rdx
               	movzbq	0x70(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	movzbq	0x71(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	movzbq	0x72(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	movzbq	0x73(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	movzbq	0x74(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	movzbq	0x75(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	movzbq	0x76(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	movzbq	0x77(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	movzbq	0x78(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	movzbq	0x79(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	movzbq	0x7a(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	movzbq	0x7b(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	movzbq	0x7c(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	movzbq	0x7d(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	movzbq	0x7e(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	movzbq	0x7f(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x4f(%rsp)
               	leaq	(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	movzbq	0x20(%rsp), %rsi
               	movzbq	0x70(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x40(%rsp)
               	movzbq	0x21(%rsp), %rsi
               	movzbq	0x71(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x41(%rsp)
               	movzbq	0x22(%rsp), %rsi
               	movzbq	0x72(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x42(%rsp)
               	movzbq	0x23(%rsp), %rsi
               	movzbq	0x73(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x43(%rsp)
               	movzbq	0x24(%rsp), %rsi
               	movzbq	0x74(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x44(%rsp)
               	movzbq	0x25(%rsp), %rsi
               	movzbq	0x75(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x45(%rsp)
               	movzbq	0x26(%rsp), %rsi
               	movzbq	0x76(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x46(%rsp)
               	movzbq	0x27(%rsp), %rsi
               	movzbq	0x77(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x47(%rsp)
               	movzbq	0x28(%rsp), %rsi
               	movzbq	0x78(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x48(%rsp)
               	movzbq	0x29(%rsp), %rsi
               	movzbq	0x79(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x49(%rsp)
               	movzbq	0x2a(%rsp), %rsi
               	movzbq	0x7a(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x4a(%rsp)
               	movzbq	0x2b(%rsp), %rsi
               	movzbq	0x7b(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x4b(%rsp)
               	movzbq	0x2c(%rsp), %rsi
               	movzbq	0x7c(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x4c(%rsp)
               	movzbq	0x2d(%rsp), %rsi
               	movzbq	0x7d(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x4d(%rsp)
               	movzbq	0x2e(%rsp), %rsi
               	movzbq	0x7e(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x4e(%rsp)
               	movzbq	0x2f(%rsp), %rsi
               	movzbq	0x7f(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x4f(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
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
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x20(%rsp), %rcx
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rdi
               	movzbq	0x20(%rsp), %rax
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
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rsi
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
               	leaq	(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x20(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rsi
               	movzbq	0x20(%rsp), %rdi
               	movzbq	0x70(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x21(%rsp), %rdi
               	movzbq	0x71(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x22(%rsp), %rdi
               	movzbq	0x72(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x23(%rsp), %rdi
               	movzbq	0x73(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x24(%rsp), %rdi
               	movzbq	0x74(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x25(%rsp), %rdi
               	movzbq	0x75(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x26(%rsp), %rdi
               	movzbq	0x76(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x27(%rsp), %rdi
               	movzbq	0x77(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x28(%rsp), %rdi
               	movzbq	0x78(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x29(%rsp), %rdi
               	movzbq	0x79(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x2a(%rsp), %rdi
               	movzbq	0x7a(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x2b(%rsp), %rdi
               	movzbq	0x7b(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x2c(%rsp), %rdi
               	movzbq	0x7c(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x2d(%rsp), %rdi
               	movzbq	0x7d(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x2e(%rsp), %rdi
               	movzbq	0x7e(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x2f(%rsp), %rdi
               	movzbq	0x7f(%rsp), %r8
               	movl	%edi, %eax
               	xorl	%edx, %edx
               	divl	%r8d
               	movb	%dl, 0x4f(%rsp)
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	(%rsp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	pand	%xmm1, %xmm0
               	leaq	0x20(%rsp), %rdx
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x40(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	pand	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	por	%xmm1, %xmm0
               	leaq	0x20(%rsp), %rdx
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x40(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	por	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	pxor	%xmm1, %xmm0
               	leaq	0x20(%rsp), %rdx
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x40(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	pxor	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
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
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	movzbq	0x20(%rsp), %rsi
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
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
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
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	movzbq	0x20(%rsp), %rsi
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
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xc0(%rsp), %rdi
               	leaq	0x40(%rsp), %rcx
               	movswq	0xc0(%rsp), %rax
               	movswq	0xd0(%rsp), %rsi
               	cqto
               	idivq	%rsi
               	movw	%ax, 0x40(%rsp)
               	movswq	0xc2(%rsp), %rax
               	movswq	0xd2(%rsp), %rsi
               	cqto
               	idivq	%rsi
               	movw	%ax, 0x42(%rsp)
               	movswq	0xc4(%rsp), %rax
               	movswq	0xd4(%rsp), %rsi
               	cqto
               	idivq	%rsi
               	movw	%ax, 0x44(%rsp)
               	movswq	0xc6(%rsp), %rax
               	movswq	0xd6(%rsp), %rsi
               	cqto
               	idivq	%rsi
               	movw	%ax, 0x46(%rsp)
               	movswq	0xc8(%rsp), %rax
               	movswq	0xd8(%rsp), %rsi
               	cqto
               	idivq	%rsi
               	movw	%ax, 0x48(%rsp)
               	movswq	0xca(%rsp), %rax
               	movswq	0xda(%rsp), %rsi
               	cqto
               	idivq	%rsi
               	movw	%ax, 0x4a(%rsp)
               	movswq	0xcc(%rsp), %rax
               	movswq	0xdc(%rsp), %rsi
               	cqto
               	idivq	%rsi
               	movw	%ax, 0x4c(%rsp)
               	movswq	0xce(%rsp), %rax
               	movswq	0xde(%rsp), %rsi
               	cqto
               	idivq	%rsi
               	movw	%ax, 0x4e(%rsp)
               	leaq	(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x20(%rsp), %rcx
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rdi
               	movswq	0x20(%rsp), %rax
               	movswq	0xd0(%rsp), %r8
               	cqto
               	idivq	%r8
               	movw	%ax, 0x40(%rsp)
               	movswq	0x22(%rsp), %rax
               	movswq	0xd2(%rsp), %r8
               	cqto
               	idivq	%r8
               	movw	%ax, 0x42(%rsp)
               	movswq	0x24(%rsp), %rax
               	movswq	0xd4(%rsp), %r8
               	cqto
               	idivq	%r8
               	movw	%ax, 0x44(%rsp)
               	movswq	0x26(%rsp), %rax
               	movswq	0xd6(%rsp), %r8
               	cqto
               	idivq	%r8
               	movw	%ax, 0x46(%rsp)
               	movswq	0x28(%rsp), %rax
               	movswq	0xd8(%rsp), %r8
               	cqto
               	idivq	%r8
               	movw	%ax, 0x48(%rsp)
               	movswq	0x2a(%rsp), %rax
               	movswq	0xda(%rsp), %r8
               	cqto
               	idivq	%r8
               	movw	%ax, 0x4a(%rsp)
               	movswq	0x2c(%rsp), %rax
               	movswq	0xdc(%rsp), %r8
               	cqto
               	idivq	%r8
               	movw	%ax, 0x4c(%rsp)
               	movswq	0x2e(%rsp), %rax
               	movswq	0xde(%rsp), %r8
               	cqto
               	idivq	%r8
               	movw	%ax, 0x4e(%rsp)
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x140(%rsp), %rax
               	movq	0x140(%rsp), %rcx
               	movq	0x150(%rsp), %rdx
               	imulq	%rdx, %rcx
               	movq	0x148(%rsp), %rdx
               	movq	0x158(%rsp), %rsi
               	imulq	%rdx, %rsi
               	leaq	0x20(%rsp), %rdx
               	movq	%rcx, 0x20(%rsp)
               	movq	%rsi, 0x28(%rsp)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	0x40(%rsp), %rax
               	movq	0x150(%rsp), %rsi
               	imulq	%rsi, %rax
               	movq	0x48(%rsp), %rsi
               	movq	0x158(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movq	%rax, 0x40(%rsp)
               	movq	%rsi, 0x48(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	movzbq	(%rsp), %rdx
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
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
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
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rcx
               	leaq	0x20(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x40(%rsp), %rcx
               	movzbq	0x20(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x21(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x22(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x23(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x24(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x25(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x26(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x27(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x28(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x29(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x2a(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x2b(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x2c(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x2d(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x2e(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x2f(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4f(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x40(%rsp), %rcx
               	movzbq	0x20(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x21(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x22(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x23(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x24(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x25(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x26(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x27(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x28(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x29(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x2a(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x2b(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x2c(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x2d(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x2e(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x2f(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4f(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x40(%rsp), %rcx
               	movzbq	0x20(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x40(%rsp)
               	movzbq	0x21(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x41(%rsp)
               	movzbq	0x22(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x42(%rsp)
               	movzbq	0x23(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x43(%rsp)
               	movzbq	0x24(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x44(%rsp)
               	movzbq	0x25(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x45(%rsp)
               	movzbq	0x26(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x46(%rsp)
               	movzbq	0x27(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x47(%rsp)
               	movzbq	0x28(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x48(%rsp)
               	movzbq	0x29(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x49(%rsp)
               	movzbq	0x2a(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4a(%rsp)
               	movzbq	0x2b(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4b(%rsp)
               	movzbq	0x2c(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4c(%rsp)
               	movzbq	0x2d(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4d(%rsp)
               	movzbq	0x2e(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4e(%rsp)
               	movzbq	0x2f(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x4f(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x60(%rsp), %rsi
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rcx
               	movzbq	(%rsi,%rax), %rdx
               	subq	$0xc0, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	0x70(%rsp), %r8
               	movups	0x60(%rsp), %xmm0
               	movups	0x70(%rsp), %xmm1
               	paddb	%xmm1, %xmm0
               	movl	$0x3, %eax
               	vpextrb	$0x0, %xmm0, %edx
               	imulq	%rax, %rdx
               	xorl	%esi, %esi
               	movq	%rsi, %xmm1
               	vpinsrb	$0x0, %edx, %xmm1, %xmm1
               	vpextrb	$0x1, %xmm0, %edx
               	imulq	%rax, %rdx
               	vpinsrb	$0x1, %edx, %xmm1, %xmm1
               	vpextrb	$0x2, %xmm0, %edx
               	imulq	%rax, %rdx
               	vpinsrb	$0x2, %edx, %xmm1, %xmm1
               	vpextrb	$0x3, %xmm0, %edx
               	imulq	%rax, %rdx
               	vpinsrb	$0x3, %edx, %xmm1, %xmm1
               	vpextrb	$0x4, %xmm0, %edx
               	imulq	%rax, %rdx
               	vpinsrb	$0x4, %edx, %xmm1, %xmm1
               	vpextrb	$0x5, %xmm0, %edx
               	imulq	%rax, %rdx
               	vpinsrb	$0x5, %edx, %xmm1, %xmm1
               	vpextrb	$0x6, %xmm0, %edx
               	imulq	%rax, %rdx
               	vpinsrb	$0x6, %edx, %xmm1, %xmm1
               	vpextrb	$0x7, %xmm0, %edx
               	imulq	%rax, %rdx
               	vpinsrb	$0x7, %edx, %xmm1, %xmm1
               	vpextrb	$0x8, %xmm0, %edx
               	imulq	%rax, %rdx
               	vpinsrb	$0x8, %edx, %xmm1, %xmm1
               	vpextrb	$0x9, %xmm0, %edx
               	imulq	%rax, %rdx
               	vpinsrb	$0x9, %edx, %xmm1, %xmm1
               	vpextrb	$0xa, %xmm0, %edx
               	imulq	%rax, %rdx
               	vpinsrb	$0xa, %edx, %xmm1, %xmm1
               	vpextrb	$0xb, %xmm0, %edx
               	imulq	%rax, %rdx
               	vpinsrb	$0xb, %edx, %xmm1, %xmm1
               	vpextrb	$0xc, %xmm0, %edx
               	imulq	%rax, %rdx
               	vpinsrb	$0xc, %edx, %xmm1, %xmm1
               	vpextrb	$0xd, %xmm0, %edx
               	imulq	%rax, %rdx
               	vpinsrb	$0xd, %edx, %xmm1, %xmm1
               	vpextrb	$0xe, %xmm0, %edx
               	imulq	%rax, %rdx
               	vpinsrb	$0xe, %edx, %xmm1, %xmm1
               	vpextrb	$0xf, %xmm0, %edx
               	imulq	%rdx, %rax
               	movapd	%xmm1, %xmm0
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	movups	0x60(%rsp), %xmm1
               	psubb	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rdi,%rax), %rdx
               	movzbq	(%r8,%rax), %rsi
               	addq	%rdx, %rsi
               	andq	$0xff, %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	andq	$0xff, %rsi
               	subq	%rdx, %rsi
               	andq	$0xff, %rsi
               	movb	%sil, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x100(%rsp), %r8
               	movslq	0x100(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rcx
               	shrq	$0x3f, %rcx
               	addq	%rax, %rcx
               	movslq	0x104(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdx
               	shrq	$0x3f, %rdx
               	addq	%rax, %rdx
               	movslq	0x108(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rax, %rsi
               	movslq	0x10c(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rax, %rdi
               	xorl	%eax, %eax
               	negq	%rcx
               	xorl	%r9d, %r9d
               	vmovd	%ecx, %xmm0
               	movq	%rdx, %rcx
               	negq	%rcx
               	vpinsrd	$0x1, %ecx, %xmm0, %xmm0
               	movq	%rsi, %rcx
               	negq	%rcx
               	vpinsrd	$0x2, %ecx, %xmm0, %xmm0
               	movq	%rdi, %rcx
               	negq	%rcx
               	vpinsrd	$0x3, %ecx, %xmm0, %xmm0
               	leaq	0x110(%rsp), %r9
               	movups	0x110(%rsp), %xmm1
               	paddd	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdx
               	movslq	(%rdx), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	addq	%r9, %rcx
               	movl	(%rcx), %ecx
               	subq	%rdx, %rcx
               	movl	%ecx, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movzbq	0x40(%rsp), %rax
               	shlq	%rax
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm0
               	vpinsrb	$0x0, %eax, %xmm0, %xmm0
               	movzbq	0x41(%rsp), %rax
               	shlq	%rax
               	vpinsrb	$0x1, %eax, %xmm0, %xmm0
               	movzbq	0x42(%rsp), %rax
               	shlq	%rax
               	vpinsrb	$0x2, %eax, %xmm0, %xmm0
               	movzbq	0x43(%rsp), %rax
               	shlq	%rax
               	vpinsrb	$0x3, %eax, %xmm0, %xmm0
               	movzbq	0x44(%rsp), %rax
               	shlq	%rax
               	vpinsrb	$0x4, %eax, %xmm0, %xmm0
               	movzbq	0x45(%rsp), %rax
               	shlq	%rax
               	vpinsrb	$0x5, %eax, %xmm0, %xmm0
               	movzbq	0x46(%rsp), %rax
               	shlq	%rax
               	vpinsrb	$0x6, %eax, %xmm0, %xmm0
               	movzbq	0x47(%rsp), %rax
               	shlq	%rax
               	vpinsrb	$0x7, %eax, %xmm0, %xmm0
               	movzbq	0x48(%rsp), %rax
               	shlq	%rax
               	vpinsrb	$0x8, %eax, %xmm0, %xmm0
               	movzbq	0x49(%rsp), %rax
               	shlq	%rax
               	vpinsrb	$0x9, %eax, %xmm0, %xmm0
               	movzbq	0x4a(%rsp), %rax
               	shlq	%rax
               	vpinsrb	$0xa, %eax, %xmm0, %xmm0
               	movzbq	0x4b(%rsp), %rax
               	shlq	%rax
               	vpinsrb	$0xb, %eax, %xmm0, %xmm0
               	movzbq	0x4c(%rsp), %rax
               	shlq	%rax
               	vpinsrb	$0xc, %eax, %xmm0, %xmm0
               	movzbq	0x4d(%rsp), %rax
               	shlq	%rax
               	vpinsrb	$0xd, %eax, %xmm0, %xmm0
               	movzbq	0x4e(%rsp), %rax
               	shlq	%rax
               	vpinsrb	$0xe, %eax, %xmm0, %xmm0
               	movzbq	0x4f(%rsp), %rax
               	shlq	%rax
               	vpinsrb	$0xf, %eax, %xmm0, %xmm0
               	movsbq	0x40(%rsp), %rax
               	movq	%rax, %rcx
               	sarq	$0x7, %rcx
               	movsbq	0x41(%rsp), %rax
               	movq	%rax, %rdx
               	sarq	$0x7, %rdx
               	movsbq	0x42(%rsp), %rax
               	movq	%rax, %rsi
               	sarq	$0x7, %rsi
               	movsbq	0x43(%rsp), %rax
               	movq	%rax, %rdi
               	sarq	$0x7, %rdi
               	movsbq	0x44(%rsp), %rax
               	movq	%rax, %r8
               	sarq	$0x7, %r8
               	movsbq	0x45(%rsp), %rax
               	movq	%rax, %r9
               	sarq	$0x7, %r9
               	movsbq	0x46(%rsp), %rax
               	movq	%rax, %rbx
               	sarq	$0x7, %rbx
               	movsbq	0x47(%rsp), %rax
               	movq	%rax, %r12
               	sarq	$0x7, %r12
               	movsbq	0x48(%rsp), %rax
               	movq	%rax, %r13
               	sarq	$0x7, %r13
               	movsbq	0x49(%rsp), %rax
               	movq	%rax, %r14
               	sarq	$0x7, %r14
               	movsbq	0x4a(%rsp), %rax
               	movq	%rax, %r15
               	sarq	$0x7, %r15
               	movsbq	0x4b(%rsp), %rax
               	movq	%rax, %r10
               	sarq	$0x7, %r10
               	movq	%r10, -0x48(%rbp)
               	movsbq	0x4c(%rsp), %rax
               	movq	%rax, %r10
               	sarq	$0x7, %r10
               	movq	%r10, -0x50(%rbp)
               	movsbq	0x4d(%rsp), %rax
               	movq	%rax, %r10
               	sarq	$0x7, %r10
               	movq	%r10, -0x58(%rbp)
               	movsbq	0x4e(%rsp), %rax
               	movq	%rax, %r10
               	sarq	$0x7, %r10
               	movq	%r10, -0x60(%rbp)
               	movsbq	0x4f(%rsp), %rax
               	movq	%rax, %r10
               	sarq	$0x7, %r10
               	movq	%r10, -0x68(%rbp)
               	movl	$0x1b, %eax
               	andq	%rax, %rcx
               	xorl	%r10d, %r10d
               	movq	%r10, -0x70(%rbp)
               	movups	-0x78(%rbp), %xmm1
               	vpinsrb	$0x0, %ecx, %xmm1, %xmm1
               	andq	%rax, %rdx
               	vpinsrb	$0x1, %edx, %xmm1, %xmm1
               	andq	%rax, %rsi
               	vpinsrb	$0x2, %esi, %xmm1, %xmm1
               	andq	%rax, %rdi
               	vpinsrb	$0x3, %edi, %xmm1, %xmm1
               	andq	%rax, %r8
               	vpinsrb	$0x4, %r8d, %xmm1, %xmm1
               	andq	%rax, %r9
               	vpinsrb	$0x5, %r9d, %xmm1, %xmm1
               	andq	%rax, %rbx
               	vpinsrb	$0x6, %ebx, %xmm1, %xmm1
               	andq	%rax, %r12
               	vpinsrb	$0x7, %r12d, %xmm1, %xmm1
               	andq	%rax, %r13
               	vpinsrb	$0x8, %r13d, %xmm1, %xmm1
               	andq	%rax, %r14
               	vpinsrb	$0x9, %r14d, %xmm1, %xmm1
               	andq	%rax, %r15
               	vpinsrb	$0xa, %r15d, %xmm1, %xmm1
               	movq	-0x48(%rbp), %rcx
               	andq	%rax, %rcx
               	vpinsrb	$0xb, %ecx, %xmm1, %xmm1
               	movq	-0x50(%rbp), %rcx
               	andq	%rax, %rcx
               	vpinsrb	$0xc, %ecx, %xmm1, %xmm1
               	movq	-0x58(%rbp), %rcx
               	andq	%rax, %rcx
               	vpinsrb	$0xd, %ecx, %xmm1, %xmm1
               	movq	-0x60(%rbp), %rcx
               	andq	%rax, %rcx
               	vpinsrb	$0xe, %ecx, %xmm1, %xmm1
               	movq	%rax, %r10
               	movq	-0x68(%rbp), %rax
               	andq	%r10, %rax
               	vpinsrb	$0xf, %eax, %xmm1, %xmm1
               	pxor	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	leaq	0x60(%rsp), %rdi
               	xorl	%eax, %eax
               	movzbq	(%rdi,%rax), %rcx
               	movsbq	%cl, %rdx
               	sarq	$0x7, %rdx
               	andq	$0x1b, %rdx
               	leaq	-0x10(%rbp), %rsi
               	shlq	%rcx
               	andq	$0xff, %rcx
               	xorq	%rdx, %rcx
               	movb	%cl, (%rsi,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rdx
               	leaq	-0x10(%rbp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	0x80(%rsp), %r8
               	movups	0x60(%rsp), %xmm0
               	movups	0x80(%rsp), %xmm1
               	paddb	%xmm1, %xmm0
               	movups	%xmm0, 0x40(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rdi,%rax), %rdx
               	movzbq	(%r8,%rax), %rsi
               	addq	%rsi, %rdx
               	andq	$0xff, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x160(%rsp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x40(%rsp), %rax
               	movb	$0x42, 0x40(%rsp)
               	xorl	%ecx, %ecx
               	movb	%cl, 0x41(%rsp)
               	movb	$0x28, 0x42(%rsp)
               	movb	%cl, 0x43(%rsp)
               	movb	$0x1d, 0x44(%rsp)
               	movb	%cl, 0x45(%rsp)
               	movb	$0x16, 0x46(%rsp)
               	movb	%cl, 0x47(%rsp)
               	movb	$0x1, 0x48(%rsp)
               	movb	$0x2, 0x49(%rsp)
               	movb	$0x3, 0x4a(%rsp)
               	movb	$0x4, 0x4b(%rsp)
               	movb	$0x5, 0x4c(%rsp)
               	movb	$0x6, 0x4d(%rsp)
               	movb	$0x7, 0x4e(%rsp)
               	movb	$0x8, 0x4f(%rsp)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %r8
               	movzbq	(%rsi,%rcx), %rax
               	movzbq	(%rdi,%rcx), %r9
               	cltd
               	idivl	%r9d
               	andq	$0xff, %rax
               	movb	%al, (%r8,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	leaq	0x20(%rsp), %rcx
               	leaq	-0x10(%rbp), %rsi
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rdx
               	movzbq	(%rsi,%rax), %rdi
               	cmpl	%edi, %edx
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x160(%rsp), %r8
               	leaq	(%rsp), %r9
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
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movsbq	(%r8,%rcx), %rax
               	movsbq	(%r9,%rcx), %rdi
               	cltd
               	idivl	%edi
               	movb	%al, (%rsi,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	leaq	0x20(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x68, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x67, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x5f, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x5e, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x5d, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x5c, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x5b, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x5a, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x59, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x58, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x57, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x56, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x55, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x54, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x53, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x52, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x51, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x50, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x4f, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x4e, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x4d, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x4c, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x4b, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x4a, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x49, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x60, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x48, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x66, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x65, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x64, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x63, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x62, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x61, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x47, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x46, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x45, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x44, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x43, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x42, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x41, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x40, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x3f, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x3e, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x3d, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x3c, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x3b, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x3a, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x39, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x38, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x37, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x36, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x35, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x34, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x33, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x32, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x31, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x30, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x2f, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x2e, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x2d, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x2c, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x2b, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x2a, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x29, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x28, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x27, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x26, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x25, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x24, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x23, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x22, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x21, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x20, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x1f, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x1e, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x1d, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x1c, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x1b, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x1a, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x19, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x18, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x17, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x16, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x15, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x14, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x13, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x12, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x11, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x10, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0xf, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0xe, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0xd, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0xc, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0xb, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0xa, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x9, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x8, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x7, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x6, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x5, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x4, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x3, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x2, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0xa0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	vzeroupper
               	leave
               	retq
