
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
               	subq	$0x88, %rsp
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
               	leaq	0x160(%rsp), %rdi
               	movb	$0x1, 0x160(%rsp)
               	movb	$0x3, 0x161(%rsp)
               	movb	$0x5, 0x162(%rsp)
               	movb	$0x7, 0x163(%rsp)
               	movb	$0x2c, 0x164(%rsp)
               	movb	$0x0, 0x165(%rsp)
               	movb	$0x0, 0x166(%rsp)
               	movb	$0x2c, 0x167(%rsp)
               	movb	$0x0, 0x168(%rsp)
               	movb	$0x8, 0x169(%rsp)
               	movb	$0xd, 0x16a(%rsp)
               	movb	$0x10, 0x16b(%rsp)
               	movb	$0x13, 0x16c(%rsp)
               	movb	$0x16, 0x16d(%rsp)
               	movb	$0x1b, 0x16e(%rsp)
               	movb	$0x1e, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
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
               	leaq	0x160(%rsp), %rax
               	movzbq	0x60(%rsp), %rdx
               	movzbq	0x70(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	movzbq	0x71(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	movzbq	0x72(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	movzbq	0x73(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	movzbq	0x74(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	movzbq	0x75(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	movzbq	0x76(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	movzbq	0x77(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	movzbq	0x78(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	movzbq	0x79(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	movzbq	0x7a(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	movzbq	0x7b(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	movzbq	0x7c(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	movzbq	0x7d(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	movzbq	0x7e(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	movzbq	0x7f(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
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
               	leaq	0x160(%rsp), %rax
               	movzbq	0x60(%rsp), %rdx
               	movzbq	0x70(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	movzbq	0x71(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	movzbq	0x72(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	movzbq	0x73(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	movzbq	0x74(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	movzbq	0x75(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	movzbq	0x76(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	movzbq	0x77(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	movzbq	0x78(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	movzbq	0x79(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	movzbq	0x7a(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	movzbq	0x7b(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	movzbq	0x7c(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	movzbq	0x7d(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	movzbq	0x7e(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	movzbq	0x7f(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rdx
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
               	leaq	0x60(%rsp), %r8
               	leaq	0x70(%rsp), %r9
               	leaq	0x160(%rsp), %rcx
               	movzbq	0x60(%rsp), %rax
               	movzbq	0x70(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%al, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rax
               	movzbq	0x71(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%al, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rax
               	movzbq	0x72(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%al, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rax
               	movzbq	0x73(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%al, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rax
               	movzbq	0x74(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%al, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rax
               	movzbq	0x75(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%al, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rax
               	movzbq	0x76(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%al, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rax
               	movzbq	0x77(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%al, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rax
               	movzbq	0x78(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%al, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rax
               	movzbq	0x79(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%al, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rax
               	movzbq	0x7a(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%al, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rax
               	movzbq	0x7b(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%al, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rax
               	movzbq	0x7c(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%al, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rax
               	movzbq	0x7d(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%al, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rax
               	movzbq	0x7e(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%al, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rax
               	movzbq	0x7f(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%al, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movzbq	(%r8,%rcx), %rax
               	movzbq	(%r9,%rcx), %rdi
               	cqto
               	idivq	%rdi
               	andq	$0xff, %rax
               	movb	%al, (%rsi,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
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
               	leaq	0x60(%rsp), %r9
               	leaq	0x70(%rsp), %rbx
               	leaq	0x160(%rsp), %rcx
               	movzbq	0x60(%rsp), %rsi
               	movzbq	0x70(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rsi
               	movzbq	0x71(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rsi
               	movzbq	0x72(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rsi
               	movzbq	0x73(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rsi
               	movzbq	0x74(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rsi
               	movzbq	0x75(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rsi
               	movzbq	0x76(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rsi
               	movzbq	0x77(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rsi
               	movzbq	0x78(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rsi
               	movzbq	0x79(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rsi
               	movzbq	0x7a(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rsi
               	movzbq	0x7b(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rsi
               	movzbq	0x7c(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rsi
               	movzbq	0x7d(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rsi
               	movzbq	0x7e(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rsi
               	movzbq	0x7f(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	leaq	-0x10(%rbp), %rsi
               	movzbq	(%r9,%rcx), %rdi
               	movzbq	(%rbx,%rcx), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rdx, %rax
               	andq	$0xff, %rax
               	movb	%al, (%rsi,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
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
               	movq	0x60(%rsp), %rax
               	movq	0x70(%rsp), %rdx
               	andq	%rdx, %rax
               	movq	0x68(%rsp), %rdx
               	movq	0x78(%rsp), %rsi
               	andq	%rsi, %rdx
               	movq	%rax, 0x160(%rsp)
               	movq	%rdx, 0x168(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rdi,%rax), %rdx
               	movzbq	(%r8,%rax), %rsi
               	andq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
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
               	movq	0x60(%rsp), %rax
               	movq	0x70(%rsp), %rdx
               	orq	%rdx, %rax
               	movq	0x68(%rsp), %rdx
               	movq	0x78(%rsp), %rsi
               	orq	%rsi, %rdx
               	movq	%rax, 0x160(%rsp)
               	movq	%rdx, 0x168(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rdi,%rax), %rdx
               	movzbq	(%r8,%rax), %rsi
               	orq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
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
               	movq	0x60(%rsp), %rax
               	movq	0x70(%rsp), %rdx
               	xorq	%rdx, %rax
               	movq	0x68(%rsp), %rdx
               	movq	0x78(%rsp), %rsi
               	xorq	%rsi, %rdx
               	movq	%rax, 0x160(%rsp)
               	movq	%rdx, 0x168(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rdi,%rax), %rdx
               	movzbq	(%r8,%rax), %rsi
               	xorq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
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
               	leaq	0x160(%rsp), %rax
               	movsbq	0x80(%rsp), %rdx
               	movsbq	0x90(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x160(%rsp)
               	movsbq	0x81(%rsp), %rdx
               	movsbq	0x91(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x161(%rsp)
               	movsbq	0x82(%rsp), %rdx
               	movsbq	0x92(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x162(%rsp)
               	movsbq	0x83(%rsp), %rdx
               	movsbq	0x93(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x163(%rsp)
               	movsbq	0x84(%rsp), %rdx
               	movsbq	0x94(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x164(%rsp)
               	movsbq	0x85(%rsp), %rdx
               	movsbq	0x95(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x165(%rsp)
               	movsbq	0x86(%rsp), %rdx
               	movsbq	0x96(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x166(%rsp)
               	movsbq	0x87(%rsp), %rdx
               	movsbq	0x97(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x167(%rsp)
               	movsbq	0x88(%rsp), %rdx
               	movsbq	0x98(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x168(%rsp)
               	movsbq	0x89(%rsp), %rdx
               	movsbq	0x99(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x169(%rsp)
               	movsbq	0x8a(%rsp), %rdx
               	movsbq	0x9a(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movsbq	0x8b(%rsp), %rdx
               	movsbq	0x9b(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movsbq	0x8c(%rsp), %rdx
               	movsbq	0x9c(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movsbq	0x8d(%rsp), %rdx
               	movsbq	0x9d(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movsbq	0x8e(%rsp), %rdx
               	movsbq	0x9e(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movsbq	0x8f(%rsp), %rdx
               	movsbq	0x9f(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
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
               	leaq	0x160(%rsp), %rax
               	movsbq	0x80(%rsp), %rdx
               	movsbq	0x90(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x160(%rsp)
               	movsbq	0x81(%rsp), %rdx
               	movsbq	0x91(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x161(%rsp)
               	movsbq	0x82(%rsp), %rdx
               	movsbq	0x92(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x162(%rsp)
               	movsbq	0x83(%rsp), %rdx
               	movsbq	0x93(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x163(%rsp)
               	movsbq	0x84(%rsp), %rdx
               	movsbq	0x94(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x164(%rsp)
               	movsbq	0x85(%rsp), %rdx
               	movsbq	0x95(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x165(%rsp)
               	movsbq	0x86(%rsp), %rdx
               	movsbq	0x96(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x166(%rsp)
               	movsbq	0x87(%rsp), %rdx
               	movsbq	0x97(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x167(%rsp)
               	movsbq	0x88(%rsp), %rdx
               	movsbq	0x98(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x168(%rsp)
               	movsbq	0x89(%rsp), %rdx
               	movsbq	0x99(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x169(%rsp)
               	movsbq	0x8a(%rsp), %rdx
               	movsbq	0x9a(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movsbq	0x8b(%rsp), %rdx
               	movsbq	0x9b(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movsbq	0x8c(%rsp), %rdx
               	movsbq	0x9c(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movsbq	0x8d(%rsp), %rdx
               	movsbq	0x9d(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movsbq	0x8e(%rsp), %rdx
               	movsbq	0x9e(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movsbq	0x8f(%rsp), %rdx
               	movsbq	0x9f(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
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
               	leaq	0x160(%rsp), %rax
               	movsbq	0x80(%rsp), %rdx
               	movsbq	0x90(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x160(%rsp)
               	movsbq	0x81(%rsp), %rdx
               	movsbq	0x91(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x161(%rsp)
               	movsbq	0x82(%rsp), %rdx
               	movsbq	0x92(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x162(%rsp)
               	movsbq	0x83(%rsp), %rdx
               	movsbq	0x93(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x163(%rsp)
               	movsbq	0x84(%rsp), %rdx
               	movsbq	0x94(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x164(%rsp)
               	movsbq	0x85(%rsp), %rdx
               	movsbq	0x95(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x165(%rsp)
               	movsbq	0x86(%rsp), %rdx
               	movsbq	0x96(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x166(%rsp)
               	movsbq	0x87(%rsp), %rdx
               	movsbq	0x97(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x167(%rsp)
               	movsbq	0x88(%rsp), %rdx
               	movsbq	0x98(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x168(%rsp)
               	movsbq	0x89(%rsp), %rdx
               	movsbq	0x99(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x169(%rsp)
               	movsbq	0x8a(%rsp), %rdx
               	movsbq	0x9a(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movsbq	0x8b(%rsp), %rdx
               	movsbq	0x9b(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movsbq	0x8c(%rsp), %rdx
               	movsbq	0x9c(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movsbq	0x8d(%rsp), %rdx
               	movsbq	0x9d(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movsbq	0x8e(%rsp), %rdx
               	movsbq	0x9e(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movsbq	0x8f(%rsp), %rdx
               	movsbq	0x9f(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rdx
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
               	leaq	0x80(%rsp), %r8
               	leaq	0x90(%rsp), %r9
               	leaq	0x160(%rsp), %rcx
               	movsbq	0x80(%rsp), %rax
               	movsbq	0x90(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x160(%rsp)
               	movsbq	0x81(%rsp), %rax
               	movsbq	0x91(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x161(%rsp)
               	movsbq	0x82(%rsp), %rax
               	movsbq	0x92(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x162(%rsp)
               	movsbq	0x83(%rsp), %rax
               	movsbq	0x93(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x163(%rsp)
               	movsbq	0x84(%rsp), %rax
               	movsbq	0x94(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x164(%rsp)
               	movsbq	0x85(%rsp), %rax
               	movsbq	0x95(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x165(%rsp)
               	movsbq	0x86(%rsp), %rax
               	movsbq	0x96(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x166(%rsp)
               	movsbq	0x87(%rsp), %rax
               	movsbq	0x97(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x167(%rsp)
               	movsbq	0x88(%rsp), %rax
               	movsbq	0x98(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x168(%rsp)
               	movsbq	0x89(%rsp), %rax
               	movsbq	0x99(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x169(%rsp)
               	movsbq	0x8a(%rsp), %rax
               	movsbq	0x9a(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x16a(%rsp)
               	movsbq	0x8b(%rsp), %rax
               	movsbq	0x9b(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x16b(%rsp)
               	movsbq	0x8c(%rsp), %rax
               	movsbq	0x9c(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x16c(%rsp)
               	movsbq	0x8d(%rsp), %rax
               	movsbq	0x9d(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x16d(%rsp)
               	movsbq	0x8e(%rsp), %rax
               	movsbq	0x9e(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x16e(%rsp)
               	movsbq	0x8f(%rsp), %rax
               	movsbq	0x9f(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movsbq	(%r8,%rcx), %rax
               	movsbq	(%r9,%rcx), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, (%rsi,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
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
               	leaq	0x80(%rsp), %r9
               	leaq	0x90(%rsp), %rbx
               	leaq	0x160(%rsp), %rcx
               	movsbq	0x80(%rsp), %rsi
               	movsbq	0x90(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x160(%rsp)
               	movsbq	0x81(%rsp), %rsi
               	movsbq	0x91(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x161(%rsp)
               	movsbq	0x82(%rsp), %rsi
               	movsbq	0x92(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x162(%rsp)
               	movsbq	0x83(%rsp), %rsi
               	movsbq	0x93(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x163(%rsp)
               	movsbq	0x84(%rsp), %rsi
               	movsbq	0x94(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x164(%rsp)
               	movsbq	0x85(%rsp), %rsi
               	movsbq	0x95(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x165(%rsp)
               	movsbq	0x86(%rsp), %rsi
               	movsbq	0x96(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x166(%rsp)
               	movsbq	0x87(%rsp), %rsi
               	movsbq	0x97(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x167(%rsp)
               	movsbq	0x88(%rsp), %rsi
               	movsbq	0x98(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x168(%rsp)
               	movsbq	0x89(%rsp), %rsi
               	movsbq	0x99(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x169(%rsp)
               	movsbq	0x8a(%rsp), %rsi
               	movsbq	0x9a(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x16a(%rsp)
               	movsbq	0x8b(%rsp), %rsi
               	movsbq	0x9b(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x16b(%rsp)
               	movsbq	0x8c(%rsp), %rsi
               	movsbq	0x9c(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x16c(%rsp)
               	movsbq	0x8d(%rsp), %rsi
               	movsbq	0x9d(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x16d(%rsp)
               	movsbq	0x8e(%rsp), %rsi
               	movsbq	0x9e(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x16e(%rsp)
               	movsbq	0x8f(%rsp), %rsi
               	movsbq	0x9f(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	leaq	-0x10(%rbp), %rsi
               	movsbq	(%r9,%rcx), %rdi
               	movsbq	(%rbx,%rcx), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movb	%dl, (%rsi,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
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
               	movq	0x80(%rsp), %rax
               	movq	0x90(%rsp), %rdx
               	andq	%rdx, %rax
               	movq	0x88(%rsp), %rdx
               	movq	0x98(%rsp), %rsi
               	andq	%rsi, %rdx
               	movq	%rax, 0x160(%rsp)
               	movq	%rdx, 0x168(%rsp)
               	xorl	%eax, %eax
               	movsbq	(%rdi,%rax), %rdx
               	movsbq	(%r8,%rax), %rsi
               	andq	%rsi, %rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
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
               	leaq	0xa0(%rsp), %r8
               	leaq	0xb0(%rsp), %r9
               	leaq	0x160(%rsp), %rax
               	movzwq	0xa0(%rsp), %rcx
               	movzwq	0xb0(%rsp), %rsi
               	addq	%rsi, %rcx
               	movw	%cx, 0x160(%rsp)
               	movzwq	0xa2(%rsp), %rcx
               	movzwq	0xb2(%rsp), %rsi
               	addq	%rsi, %rcx
               	movw	%cx, 0x162(%rsp)
               	movzwq	0xa4(%rsp), %rcx
               	movzwq	0xb4(%rsp), %rsi
               	addq	%rsi, %rcx
               	movw	%cx, 0x164(%rsp)
               	movzwq	0xa6(%rsp), %rcx
               	movzwq	0xb6(%rsp), %rsi
               	addq	%rsi, %rcx
               	movw	%cx, 0x166(%rsp)
               	movzwq	0xa8(%rsp), %rcx
               	movzwq	0xb8(%rsp), %rsi
               	addq	%rsi, %rcx
               	movw	%cx, 0x168(%rsp)
               	movzwq	0xaa(%rsp), %rcx
               	movzwq	0xba(%rsp), %rsi
               	addq	%rsi, %rcx
               	movw	%cx, 0x16a(%rsp)
               	movzwq	0xac(%rsp), %rcx
               	movzwq	0xbc(%rsp), %rsi
               	addq	%rsi, %rcx
               	movw	%cx, 0x16c(%rsp)
               	movzwq	0xae(%rsp), %rcx
               	movzwq	0xbe(%rsp), %rsi
               	addq	%rsi, %rcx
               	movw	%cx, 0x16e(%rsp)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
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
               	leaq	0x160(%rsp), %rax
               	movzwq	0xa0(%rsp), %rcx
               	movzwq	0xb0(%rsp), %rsi
               	subq	%rsi, %rcx
               	movw	%cx, 0x160(%rsp)
               	movzwq	0xa2(%rsp), %rcx
               	movzwq	0xb2(%rsp), %rsi
               	subq	%rsi, %rcx
               	movw	%cx, 0x162(%rsp)
               	movzwq	0xa4(%rsp), %rcx
               	movzwq	0xb4(%rsp), %rsi
               	subq	%rsi, %rcx
               	movw	%cx, 0x164(%rsp)
               	movzwq	0xa6(%rsp), %rcx
               	movzwq	0xb6(%rsp), %rsi
               	subq	%rsi, %rcx
               	movw	%cx, 0x166(%rsp)
               	movzwq	0xa8(%rsp), %rcx
               	movzwq	0xb8(%rsp), %rsi
               	subq	%rsi, %rcx
               	movw	%cx, 0x168(%rsp)
               	movzwq	0xaa(%rsp), %rcx
               	movzwq	0xba(%rsp), %rsi
               	subq	%rsi, %rcx
               	movw	%cx, 0x16a(%rsp)
               	movzwq	0xac(%rsp), %rcx
               	movzwq	0xbc(%rsp), %rsi
               	subq	%rsi, %rcx
               	movw	%cx, 0x16c(%rsp)
               	movzwq	0xae(%rsp), %rcx
               	movzwq	0xbe(%rsp), %rsi
               	subq	%rsi, %rcx
               	movw	%cx, 0x16e(%rsp)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	%rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movzwq	(%rdi), %rdi
               	addq	%r9, %rcx
               	movzwq	(%rcx), %rcx
               	subq	%rcx, %rdi
               	movq	%rdi, %rcx
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
               	leaq	0x160(%rsp), %rax
               	movzwq	0xa0(%rsp), %rcx
               	movzwq	0xb0(%rsp), %rsi
               	imulq	%rsi, %rcx
               	movw	%cx, 0x160(%rsp)
               	movzwq	0xa2(%rsp), %rcx
               	movzwq	0xb2(%rsp), %rsi
               	imulq	%rsi, %rcx
               	movw	%cx, 0x162(%rsp)
               	movzwq	0xa4(%rsp), %rcx
               	movzwq	0xb4(%rsp), %rsi
               	imulq	%rsi, %rcx
               	movw	%cx, 0x164(%rsp)
               	movzwq	0xa6(%rsp), %rcx
               	movzwq	0xb6(%rsp), %rsi
               	imulq	%rsi, %rcx
               	movw	%cx, 0x166(%rsp)
               	movzwq	0xa8(%rsp), %rcx
               	movzwq	0xb8(%rsp), %rsi
               	imulq	%rsi, %rcx
               	movw	%cx, 0x168(%rsp)
               	movzwq	0xaa(%rsp), %rcx
               	movzwq	0xba(%rsp), %rsi
               	imulq	%rsi, %rcx
               	movw	%cx, 0x16a(%rsp)
               	movzwq	0xac(%rsp), %rcx
               	movzwq	0xbc(%rsp), %rsi
               	imulq	%rsi, %rcx
               	movw	%cx, 0x16c(%rsp)
               	movzwq	0xae(%rsp), %rcx
               	movzwq	0xbe(%rsp), %rsi
               	imulq	%rsi, %rcx
               	movw	%cx, 0x16e(%rsp)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
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
               	leaq	0x160(%rsp), %rcx
               	movzwq	0xa0(%rsp), %rax
               	movzwq	0xb0(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movw	%ax, 0x160(%rsp)
               	movzwq	0xa2(%rsp), %rax
               	movzwq	0xb2(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movw	%ax, 0x162(%rsp)
               	movzwq	0xa4(%rsp), %rax
               	movzwq	0xb4(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movw	%ax, 0x164(%rsp)
               	movzwq	0xa6(%rsp), %rax
               	movzwq	0xb6(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movw	%ax, 0x166(%rsp)
               	movzwq	0xa8(%rsp), %rax
               	movzwq	0xb8(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movw	%ax, 0x168(%rsp)
               	movzwq	0xaa(%rsp), %rax
               	movzwq	0xba(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movw	%ax, 0x16a(%rsp)
               	movzwq	0xac(%rsp), %rax
               	movzwq	0xbc(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movw	%ax, 0x16c(%rsp)
               	movzwq	0xae(%rsp), %rax
               	movzwq	0xbe(%rsp), %rdi
               	xorl	%edx, %edx
               	divq	%rdi
               	movw	%ax, 0x16e(%rsp)
               	leaq	0x40(%rsp), %rax
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
               	cqto
               	idivq	%r8
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, (%rdi)
               	incq	%rcx
               	cmpl	$0x8, %ecx
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
               	leaq	0xa0(%rsp), %r9
               	leaq	0xb0(%rsp), %rbx
               	leaq	0x160(%rsp), %rcx
               	movzwq	0xa0(%rsp), %rsi
               	movzwq	0xb0(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movw	%dx, 0x160(%rsp)
               	movzwq	0xa2(%rsp), %rsi
               	movzwq	0xb2(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movw	%dx, 0x162(%rsp)
               	movzwq	0xa4(%rsp), %rsi
               	movzwq	0xb4(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movw	%dx, 0x164(%rsp)
               	movzwq	0xa6(%rsp), %rsi
               	movzwq	0xb6(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movw	%dx, 0x166(%rsp)
               	movzwq	0xa8(%rsp), %rsi
               	movzwq	0xb8(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movw	%dx, 0x168(%rsp)
               	movzwq	0xaa(%rsp), %rsi
               	movzwq	0xba(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movw	%dx, 0x16a(%rsp)
               	movzwq	0xac(%rsp), %rsi
               	movzwq	0xbc(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movw	%dx, 0x16c(%rsp)
               	movzwq	0xae(%rsp), %rsi
               	movzwq	0xbe(%rsp), %rdi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movw	%dx, 0x16e(%rsp)
               	leaq	0x40(%rsp), %rax
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
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rdx, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	movw	%ax, (%rsi)
               	incq	%rcx
               	cmpl	$0x8, %ecx
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
               	leaq	0x160(%rsp), %rax
               	movswq	0xc0(%rsp), %rcx
               	movswq	0xd0(%rsp), %rsi
               	addq	%rsi, %rcx
               	movw	%cx, 0x160(%rsp)
               	movswq	0xc2(%rsp), %rcx
               	movswq	0xd2(%rsp), %rsi
               	addq	%rsi, %rcx
               	movw	%cx, 0x162(%rsp)
               	movswq	0xc4(%rsp), %rcx
               	movswq	0xd4(%rsp), %rsi
               	addq	%rsi, %rcx
               	movw	%cx, 0x164(%rsp)
               	movswq	0xc6(%rsp), %rcx
               	movswq	0xd6(%rsp), %rsi
               	addq	%rsi, %rcx
               	movw	%cx, 0x166(%rsp)
               	movswq	0xc8(%rsp), %rcx
               	movswq	0xd8(%rsp), %rsi
               	addq	%rsi, %rcx
               	movw	%cx, 0x168(%rsp)
               	movswq	0xca(%rsp), %rcx
               	movswq	0xda(%rsp), %rsi
               	addq	%rsi, %rcx
               	movw	%cx, 0x16a(%rsp)
               	movswq	0xcc(%rsp), %rcx
               	movswq	0xdc(%rsp), %rsi
               	addq	%rsi, %rcx
               	movw	%cx, 0x16c(%rsp)
               	movswq	0xce(%rsp), %rcx
               	movswq	0xde(%rsp), %rsi
               	addq	%rsi, %rcx
               	movw	%cx, 0x16e(%rsp)
               	leaq	0x40(%rsp), %rcx
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
               	leaq	0x160(%rsp), %rax
               	movswq	0xc0(%rsp), %rcx
               	movswq	0xd0(%rsp), %rsi
               	subq	%rsi, %rcx
               	movw	%cx, 0x160(%rsp)
               	movswq	0xc2(%rsp), %rcx
               	movswq	0xd2(%rsp), %rsi
               	subq	%rsi, %rcx
               	movw	%cx, 0x162(%rsp)
               	movswq	0xc4(%rsp), %rcx
               	movswq	0xd4(%rsp), %rsi
               	subq	%rsi, %rcx
               	movw	%cx, 0x164(%rsp)
               	movswq	0xc6(%rsp), %rcx
               	movswq	0xd6(%rsp), %rsi
               	subq	%rsi, %rcx
               	movw	%cx, 0x166(%rsp)
               	movswq	0xc8(%rsp), %rcx
               	movswq	0xd8(%rsp), %rsi
               	subq	%rsi, %rcx
               	movw	%cx, 0x168(%rsp)
               	movswq	0xca(%rsp), %rcx
               	movswq	0xda(%rsp), %rsi
               	subq	%rsi, %rcx
               	movw	%cx, 0x16a(%rsp)
               	movswq	0xcc(%rsp), %rcx
               	movswq	0xdc(%rsp), %rsi
               	subq	%rsi, %rcx
               	movw	%cx, 0x16c(%rsp)
               	movswq	0xce(%rsp), %rcx
               	movswq	0xde(%rsp), %rsi
               	subq	%rsi, %rcx
               	movw	%cx, 0x16e(%rsp)
               	leaq	0x40(%rsp), %rcx
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
               	leaq	0x160(%rsp), %rax
               	movswq	0xc0(%rsp), %rcx
               	movswq	0xd0(%rsp), %rsi
               	imulq	%rsi, %rcx
               	movw	%cx, 0x160(%rsp)
               	movswq	0xc2(%rsp), %rcx
               	movswq	0xd2(%rsp), %rsi
               	imulq	%rsi, %rcx
               	movw	%cx, 0x162(%rsp)
               	movswq	0xc4(%rsp), %rcx
               	movswq	0xd4(%rsp), %rsi
               	imulq	%rsi, %rcx
               	movw	%cx, 0x164(%rsp)
               	movswq	0xc6(%rsp), %rcx
               	movswq	0xd6(%rsp), %rsi
               	imulq	%rsi, %rcx
               	movw	%cx, 0x166(%rsp)
               	movswq	0xc8(%rsp), %rcx
               	movswq	0xd8(%rsp), %rsi
               	imulq	%rsi, %rcx
               	movw	%cx, 0x168(%rsp)
               	movswq	0xca(%rsp), %rcx
               	movswq	0xda(%rsp), %rsi
               	imulq	%rsi, %rcx
               	movw	%cx, 0x16a(%rsp)
               	movswq	0xcc(%rsp), %rcx
               	movswq	0xdc(%rsp), %rsi
               	imulq	%rsi, %rcx
               	movw	%cx, 0x16c(%rsp)
               	movswq	0xce(%rsp), %rcx
               	movswq	0xde(%rsp), %rsi
               	imulq	%rsi, %rcx
               	movw	%cx, 0x16e(%rsp)
               	leaq	0x40(%rsp), %rcx
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
               	leaq	0x160(%rsp), %rcx
               	movswq	0xc0(%rsp), %rax
               	movswq	0xd0(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movw	%ax, 0x160(%rsp)
               	movswq	0xc2(%rsp), %rax
               	movswq	0xd2(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movw	%ax, 0x162(%rsp)
               	movswq	0xc4(%rsp), %rax
               	movswq	0xd4(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movw	%ax, 0x164(%rsp)
               	movswq	0xc6(%rsp), %rax
               	movswq	0xd6(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movw	%ax, 0x166(%rsp)
               	movswq	0xc8(%rsp), %rax
               	movswq	0xd8(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movw	%ax, 0x168(%rsp)
               	movswq	0xca(%rsp), %rax
               	movswq	0xda(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movw	%ax, 0x16a(%rsp)
               	movswq	0xcc(%rsp), %rax
               	movswq	0xdc(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movw	%ax, 0x16c(%rsp)
               	movswq	0xce(%rsp), %rax
               	movswq	0xde(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movw	%ax, 0x16e(%rsp)
               	leaq	0x40(%rsp), %rax
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
               	cqto
               	idivq	%r8
               	movw	%ax, (%rdi)
               	incq	%rcx
               	cmpl	$0x8, %ecx
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
               	leaq	0xc0(%rsp), %r9
               	leaq	0xd0(%rsp), %rbx
               	leaq	0x160(%rsp), %rcx
               	movswq	0xc0(%rsp), %rsi
               	movswq	0xd0(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movw	%dx, 0x160(%rsp)
               	movswq	0xc2(%rsp), %rsi
               	movswq	0xd2(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movw	%dx, 0x162(%rsp)
               	movswq	0xc4(%rsp), %rsi
               	movswq	0xd4(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movw	%dx, 0x164(%rsp)
               	movswq	0xc6(%rsp), %rsi
               	movswq	0xd6(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movw	%dx, 0x166(%rsp)
               	movswq	0xc8(%rsp), %rsi
               	movswq	0xd8(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movw	%dx, 0x168(%rsp)
               	movswq	0xca(%rsp), %rsi
               	movswq	0xda(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movw	%dx, 0x16a(%rsp)
               	movswq	0xcc(%rsp), %rsi
               	movswq	0xdc(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movw	%dx, 0x16c(%rsp)
               	movswq	0xce(%rsp), %rsi
               	movswq	0xde(%rsp), %rdi
               	movq	%rsi, %rax
               	cqto
               	idivq	%rdi
               	movw	%dx, 0x16e(%rsp)
               	leaq	0x40(%rsp), %rax
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
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movw	%dx, (%rsi)
               	incq	%rcx
               	cmpl	$0x8, %ecx
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
               	addq	%rcx, %rax
               	movl	0xe4(%rsp), %ecx
               	movl	0xf4(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	0xe8(%rsp), %edx
               	movl	0xf8(%rsp), %esi
               	addq	%rsi, %rdx
               	movl	0xec(%rsp), %esi
               	movl	0xfc(%rsp), %r9d
               	addq	%r9, %rsi
               	movl	%eax, 0x160(%rsp)
               	movl	%ecx, 0x164(%rsp)
               	movl	%edx, 0x168(%rsp)
               	movl	%esi, 0x16c(%rsp)
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rdx
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
               	cmpl	$0x4, %eax
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
               	leaq	0xe0(%rsp), %rdi
               	leaq	0xf0(%rsp), %r8
               	movl	0xe0(%rsp), %eax
               	movl	0xf0(%rsp), %ecx
               	subq	%rcx, %rax
               	movl	0xe4(%rsp), %ecx
               	movl	0xf4(%rsp), %edx
               	subq	%rdx, %rcx
               	movl	0xe8(%rsp), %edx
               	movl	0xf8(%rsp), %esi
               	subq	%rsi, %rdx
               	movl	0xec(%rsp), %esi
               	movl	0xfc(%rsp), %r9d
               	subq	%r9, %rsi
               	movl	%eax, 0x160(%rsp)
               	movl	%ecx, 0x164(%rsp)
               	movl	%edx, 0x168(%rsp)
               	movl	%esi, 0x16c(%rsp)
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rdi,%rcx), %rsi
               	movl	(%rsi), %esi
               	addq	%r8, %rcx
               	movl	(%rcx), %ecx
               	subq	%rcx, %rsi
               	movl	%esi, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
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
               	movl	%eax, 0x160(%rsp)
               	movl	%ecx, 0x164(%rsp)
               	movl	%edx, 0x168(%rsp)
               	movl	%esi, 0x16c(%rsp)
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
               	movl	0xe0(%rsp), %eax
               	movl	0xf0(%rsp), %ecx
               	xorl	%edx, %edx
               	divq	%rcx
               	movq	%rax, %rcx
               	movl	0xe4(%rsp), %eax
               	movl	0xf4(%rsp), %esi
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rax, %rsi
               	movl	0xe8(%rsp), %eax
               	movl	0xf8(%rsp), %edi
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rax, %rdi
               	movl	0xec(%rsp), %eax
               	movl	0xfc(%rsp), %edx
               	movq	%rdx, %r10
               	xorl	%edx, %edx
               	divq	%r10
               	movl	%ecx, 0x160(%rsp)
               	movl	%esi, 0x164(%rsp)
               	movl	%edi, 0x168(%rsp)
               	movl	%eax, 0x16c(%rsp)
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
               	divq	%rdi
               	movl	%eax, (%rsi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
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
               	leaq	0xe0(%rsp), %r9
               	movl	0xe0(%rsp), %ecx
               	movl	0xf0(%rsp), %esi
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%rsi
               	movq	%rdx, %rcx
               	movl	0xe4(%rsp), %esi
               	movl	0xf4(%rsp), %edi
               	movq	%rsi, %rax
               	xorl	%edx, %edx
               	divq	%rdi
               	movq	%rdx, %rsi
               	movl	0xe8(%rsp), %edi
               	movl	0xf8(%rsp), %r8d
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movq	%rdx, %rdi
               	movl	0xec(%rsp), %r8d
               	movl	0xfc(%rsp), %eax
               	movq	%rax, %r10
               	movq	%r8, %rax
               	xorl	%edx, %edx
               	divq	%r10
               	movl	%ecx, 0x160(%rsp)
               	movl	%esi, 0x164(%rsp)
               	movl	%edi, 0x168(%rsp)
               	movl	%edx, 0x16c(%rsp)
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
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movl	%edx, (%rsi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
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
               	leaq	0x100(%rsp), %rdi
               	leaq	0x110(%rsp), %r8
               	movl	0x100(%rsp), %eax
               	movl	0x110(%rsp), %ecx
               	addq	%rcx, %rax
               	movl	0x104(%rsp), %ecx
               	movl	0x114(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	0x108(%rsp), %edx
               	movl	0x118(%rsp), %esi
               	addq	%rsi, %rdx
               	movl	0x10c(%rsp), %esi
               	movl	0x11c(%rsp), %r9d
               	addq	%r9, %rsi
               	movl	%eax, 0x160(%rsp)
               	movl	%ecx, 0x164(%rsp)
               	movl	%edx, 0x168(%rsp)
               	movl	%esi, 0x16c(%rsp)
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rdx
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
               	cmpl	$0x4, %eax
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
               	leaq	0x100(%rsp), %rdi
               	leaq	0x110(%rsp), %r8
               	movl	0x100(%rsp), %eax
               	movl	0x110(%rsp), %ecx
               	subq	%rcx, %rax
               	movl	0x104(%rsp), %ecx
               	movl	0x114(%rsp), %edx
               	subq	%rdx, %rcx
               	movl	0x108(%rsp), %edx
               	movl	0x118(%rsp), %esi
               	subq	%rsi, %rdx
               	movl	0x10c(%rsp), %esi
               	movl	0x11c(%rsp), %r9d
               	subq	%r9, %rsi
               	movl	%eax, 0x160(%rsp)
               	movl	%ecx, 0x164(%rsp)
               	movl	%edx, 0x168(%rsp)
               	movl	%esi, 0x16c(%rsp)
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rdx
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdx
               	leaq	(%rdi,%rcx), %rsi
               	movl	(%rsi), %esi
               	addq	%r8, %rcx
               	movl	(%rcx), %ecx
               	subq	%rcx, %rsi
               	movl	%esi, (%rdx)
               	incq	%rax
               	cmpl	$0x4, %eax
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
               	movl	%eax, 0x160(%rsp)
               	movl	%ecx, 0x164(%rsp)
               	movl	%edx, 0x168(%rsp)
               	movl	%esi, 0x16c(%rsp)
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
               	movl	%ecx, 0x160(%rsp)
               	movl	%esi, 0x164(%rsp)
               	movl	%edi, 0x168(%rsp)
               	movl	%eax, 0x16c(%rsp)
               	xorl	%ecx, %ecx
               	leaq	-0x10(%rbp), %rax
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rax,%rdx), %rsi
               	leaq	(%r8,%rdx), %rax
               	movslq	(%rax), %rax
               	addq	%r9, %rdx
               	movslq	(%rdx), %rdi
               	cqto
               	idivq	%rdi
               	movl	%eax, (%rsi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
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
               	movl	%ecx, 0x160(%rsp)
               	movl	%esi, 0x164(%rsp)
               	movl	%edi, 0x168(%rsp)
               	movl	%edx, 0x16c(%rsp)
               	leaq	0x110(%rsp), %rbx
               	xorl	%ecx, %ecx
               	leaq	-0x10(%rbp), %rax
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rax,%rdx), %rsi
               	leaq	(%r9,%rdx), %rax
               	movslq	(%rax), %rdi
               	leaq	(%rbx,%rdx), %rax
               	movslq	(%rax), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movl	%edx, (%rsi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
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
               	leaq	0x120(%rsp), %r8
               	leaq	0x130(%rsp), %r9
               	movq	0x120(%rsp), %rax
               	movq	0x130(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x128(%rsp), %rcx
               	movq	0x138(%rsp), %rsi
               	addq	%rsi, %rcx
               	movq	%rax, 0x160(%rsp)
               	movq	%rcx, 0x168(%rsp)
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
               	leaq	0x120(%rsp), %r8
               	leaq	0x130(%rsp), %r9
               	movq	0x120(%rsp), %rax
               	movq	0x130(%rsp), %rcx
               	subq	%rcx, %rax
               	movq	0x128(%rsp), %rcx
               	movq	0x138(%rsp), %rsi
               	subq	%rsi, %rcx
               	movq	%rax, 0x160(%rsp)
               	movq	%rcx, 0x168(%rsp)
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
               	leaq	0x120(%rsp), %r8
               	leaq	0x130(%rsp), %r9
               	movq	0x120(%rsp), %rax
               	movq	0x130(%rsp), %rcx
               	imulq	%rcx, %rax
               	movq	0x128(%rsp), %rcx
               	movq	0x138(%rsp), %rsi
               	imulq	%rsi, %rcx
               	movq	%rax, 0x160(%rsp)
               	movq	%rcx, 0x168(%rsp)
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
               	movq	%rcx, 0x160(%rsp)
               	movq	%rax, 0x168(%rsp)
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
               	movq	%rcx, 0x160(%rsp)
               	movq	%rdx, 0x168(%rsp)
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
               	leaq	0x140(%rsp), %r8
               	leaq	0x150(%rsp), %r9
               	movq	0x140(%rsp), %rax
               	movq	0x150(%rsp), %rcx
               	addq	%rcx, %rax
               	movq	0x148(%rsp), %rcx
               	movq	0x158(%rsp), %rsi
               	addq	%rsi, %rcx
               	movq	%rax, 0x160(%rsp)
               	movq	%rcx, 0x168(%rsp)
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
               	leaq	0x140(%rsp), %r8
               	leaq	0x150(%rsp), %r9
               	movq	0x140(%rsp), %rax
               	movq	0x150(%rsp), %rcx
               	subq	%rcx, %rax
               	movq	0x148(%rsp), %rcx
               	movq	0x158(%rsp), %rsi
               	subq	%rsi, %rcx
               	movq	%rax, 0x160(%rsp)
               	movq	%rcx, 0x168(%rsp)
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
               	leaq	0x140(%rsp), %r8
               	leaq	0x150(%rsp), %r9
               	movq	0x140(%rsp), %rax
               	movq	0x150(%rsp), %rcx
               	imulq	%rcx, %rax
               	movq	0x148(%rsp), %rcx
               	movq	0x158(%rsp), %rsi
               	imulq	%rsi, %rcx
               	movq	%rax, 0x160(%rsp)
               	movq	%rcx, 0x168(%rsp)
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
               	movq	%rcx, 0x160(%rsp)
               	movq	%rax, 0x168(%rsp)
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
               	movq	%rcx, 0x160(%rsp)
               	movq	%rdx, 0x168(%rsp)
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
               	leaq	-0x38(%rbp), %rdi
               	leaq	-0x30(%rbp), %r8
               	leaq	-0x8(%rbp), %rax
               	movzbq	-0x38(%rbp), %rcx
               	movzbq	-0x30(%rbp), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, -0x8(%rbp)
               	movzbq	-0x37(%rbp), %rcx
               	movzbq	-0x2f(%rbp), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, -0x7(%rbp)
               	movzbq	-0x36(%rbp), %rcx
               	movzbq	-0x2e(%rbp), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, -0x6(%rbp)
               	movzbq	-0x35(%rbp), %rcx
               	movzbq	-0x2d(%rbp), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, -0x5(%rbp)
               	movzbq	-0x34(%rbp), %rcx
               	movzbq	-0x2c(%rbp), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, -0x4(%rbp)
               	movzbq	-0x33(%rbp), %rcx
               	movzbq	-0x2b(%rbp), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, -0x3(%rbp)
               	movzbq	-0x32(%rbp), %rcx
               	movzbq	-0x2a(%rbp), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, -0x2(%rbp)
               	movzbq	-0x31(%rbp), %rcx
               	movzbq	-0x29(%rbp), %rdx
               	addq	%rdx, %rcx
               	movb	%cl, -0x1(%rbp)
               	leaq	-0x28(%rbp), %rcx
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
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
               	leaq	0x160(%rsp), %rax
               	movl	(%rsp), %ecx
               	movl	0x20(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x160(%rsp)
               	movl	0x4(%rsp), %ecx
               	movl	0x24(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x164(%rsp)
               	movl	0x8(%rsp), %ecx
               	movl	0x28(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x168(%rsp)
               	movl	0xc(%rsp), %ecx
               	movl	0x2c(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x16c(%rsp)
               	movl	0x10(%rsp), %ecx
               	movl	0x30(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x170(%rsp)
               	movl	0x14(%rsp), %ecx
               	movl	0x34(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x174(%rsp)
               	movl	0x18(%rsp), %ecx
               	movl	0x38(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x178(%rsp)
               	movl	0x1c(%rsp), %ecx
               	movl	0x3c(%rsp), %edx
               	addq	%rdx, %rcx
               	movl	%ecx, 0x17c(%rsp)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
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
               	leaq	0x160(%rsp), %rax
               	movl	(%rsp), %ecx
               	movl	0x20(%rsp), %esi
               	subq	%rsi, %rcx
               	movl	%ecx, 0x160(%rsp)
               	movl	0x4(%rsp), %ecx
               	movl	0x24(%rsp), %esi
               	subq	%rsi, %rcx
               	movl	%ecx, 0x164(%rsp)
               	movl	0x8(%rsp), %ecx
               	movl	0x28(%rsp), %esi
               	subq	%rsi, %rcx
               	movl	%ecx, 0x168(%rsp)
               	movl	0xc(%rsp), %ecx
               	movl	0x2c(%rsp), %esi
               	subq	%rsi, %rcx
               	movl	%ecx, 0x16c(%rsp)
               	movl	0x10(%rsp), %ecx
               	movl	0x30(%rsp), %esi
               	subq	%rsi, %rcx
               	movl	%ecx, 0x170(%rsp)
               	movl	0x14(%rsp), %ecx
               	movl	0x34(%rsp), %esi
               	subq	%rsi, %rcx
               	movl	%ecx, 0x174(%rsp)
               	movl	0x18(%rsp), %ecx
               	movl	0x38(%rsp), %esi
               	subq	%rsi, %rcx
               	movl	%ecx, 0x178(%rsp)
               	movl	0x1c(%rsp), %ecx
               	movl	0x3c(%rsp), %esi
               	subq	%rsi, %rcx
               	movl	%ecx, 0x17c(%rsp)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
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
               	leaq	(%rsp), %rcx
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rdx
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x60(%rsp), %r8
               	leaq	0x160(%rsp), %rax
               	movzbq	0x60(%rsp), %rdx
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	shlq	%rdx
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	shlq	$0x4, %rdx
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	shlq	$0x5, %rdx
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	shlq	$0x6, %rdx
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	shlq	$0x7, %rdx
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	shlq	%rdx
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	shlq	$0x3, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	shlq	$0x4, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	shlq	$0x5, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	shlq	$0x6, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	shlq	$0x7, %rdx
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rdx
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
               	leaq	(%rsp), %r8
               	leaq	0x160(%rsp), %rax
               	movzbq	0x60(%rsp), %rdx
               	movzbq	(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	movzbq	0x1(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	movzbq	0x2(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	movzbq	0x3(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	movzbq	0x4(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	movzbq	0x5(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	movzbq	0x6(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	movzbq	0x7(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	movzbq	0x8(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	movzbq	0x9(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	movzbq	0xa(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	movzbq	0xb(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	movzbq	0xc(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	movzbq	0xd(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	movzbq	0xe(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	movzbq	0xf(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rdx
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
               	leaq	0x20(%rsp), %r9
               	leaq	0x160(%rsp), %rax
               	movswq	0xc0(%rsp), %rcx
               	movswq	0x20(%rsp), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x160(%rsp)
               	movswq	0xc2(%rsp), %rcx
               	movswq	0x22(%rsp), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x162(%rsp)
               	movswq	0xc4(%rsp), %rcx
               	movswq	0x24(%rsp), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x164(%rsp)
               	movswq	0xc6(%rsp), %rcx
               	movswq	0x26(%rsp), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x166(%rsp)
               	movswq	0xc8(%rsp), %rcx
               	movswq	0x28(%rsp), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x168(%rsp)
               	movswq	0xca(%rsp), %rcx
               	movswq	0x2a(%rsp), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x16a(%rsp)
               	movswq	0xcc(%rsp), %rcx
               	movswq	0x2c(%rsp), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x16c(%rsp)
               	movswq	0xce(%rsp), %rcx
               	movswq	0x2e(%rsp), %rsi
               	sarxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x16e(%rsp)
               	leaq	0x40(%rsp), %rcx
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
               	leaq	0x20(%rsp), %r9
               	leaq	0x160(%rsp), %rax
               	movswq	0xc0(%rsp), %rcx
               	movswq	0x20(%rsp), %rsi
               	shlxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x160(%rsp)
               	movswq	0xc2(%rsp), %rcx
               	movswq	0x22(%rsp), %rsi
               	shlxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x162(%rsp)
               	movswq	0xc4(%rsp), %rcx
               	movswq	0x24(%rsp), %rsi
               	shlxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x164(%rsp)
               	movswq	0xc6(%rsp), %rcx
               	movswq	0x26(%rsp), %rsi
               	shlxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x166(%rsp)
               	movswq	0xc8(%rsp), %rcx
               	movswq	0x28(%rsp), %rsi
               	shlxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x168(%rsp)
               	movswq	0xca(%rsp), %rcx
               	movswq	0x2a(%rsp), %rsi
               	shlxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x16a(%rsp)
               	movswq	0xcc(%rsp), %rcx
               	movswq	0x2c(%rsp), %rsi
               	shlxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x16c(%rsp)
               	movswq	0xce(%rsp), %rcx
               	movswq	0x2e(%rsp), %rsi
               	shlxq	%rsi, %rcx, %rcx
               	movw	%cx, 0x16e(%rsp)
               	leaq	0x40(%rsp), %rcx
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
               	leaq	0x100(%rsp), %rdi
               	movslq	0x100(%rsp), %rax
               	sarq	$0x3, %rax
               	movslq	0x104(%rsp), %rdx
               	sarq	$0x3, %rdx
               	movslq	0x108(%rsp), %rsi
               	sarq	$0x3, %rsi
               	movslq	0x10c(%rsp), %r8
               	sarq	$0x3, %r8
               	movl	%eax, 0x160(%rsp)
               	movl	%edx, 0x164(%rsp)
               	movl	%esi, 0x168(%rsp)
               	movl	%r8d, 0x16c(%rsp)
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
               	leaq	0xe0(%rsp), %rdi
               	movl	0xe0(%rsp), %eax
               	shrq	$0x3, %rax
               	movl	0xe4(%rsp), %edx
               	shrq	$0x3, %rdx
               	movl	0xe8(%rsp), %esi
               	shrq	$0x3, %rsi
               	movl	0xec(%rsp), %r8d
               	shrq	$0x3, %r8
               	movl	%eax, 0x160(%rsp)
               	movl	%edx, 0x164(%rsp)
               	movl	%esi, 0x168(%rsp)
               	movl	%r8d, 0x16c(%rsp)
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
               	leaq	0x80(%rsp), %rsi
               	leaq	0x160(%rsp), %rax
               	movsbq	0x80(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x160(%rsp)
               	movsbq	0x81(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x161(%rsp)
               	movsbq	0x82(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x162(%rsp)
               	movsbq	0x83(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x163(%rsp)
               	movsbq	0x84(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x164(%rsp)
               	movsbq	0x85(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x165(%rsp)
               	movsbq	0x86(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x166(%rsp)
               	movsbq	0x87(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x167(%rsp)
               	movsbq	0x88(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x168(%rsp)
               	movsbq	0x89(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x169(%rsp)
               	movsbq	0x8a(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movsbq	0x8b(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movsbq	0x8c(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movsbq	0x8d(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movsbq	0x8e(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movsbq	0x8f(%rsp), %rdx
               	shlq	$0x2, %rdx
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rdx
               	shlq	$0x2, %rdx
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
               	leaq	0x60(%rsp), %rsi
               	leaq	0x160(%rsp), %rax
               	movzbq	0x60(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rdx
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
               	leaq	0x160(%rsp), %rax
               	movzbq	0x60(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	addq	$0x64, %rdx
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rdx
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
               	movl	$0x7, %eax
               	leaq	0x160(%rsp), %rdx
               	movzbq	0x60(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdi
               	imulq	%rax, %rdi
               	movb	%dil, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdi
               	imulq	%rdi, %rax
               	movb	%al, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rax
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
               	leaq	0x160(%rsp), %rax
               	movzbq	0x60(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	imulq	$0x24924925, %rdx, %rdx # imm = 0x24924925
               	shrq	$0x20, %rdx
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rdx
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
               	leaq	0x160(%rsp), %rdx
               	movzbq	0x60(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rax
               	imulq	$0x24924925, %rax, %rsi # imm = 0x24924925
               	shrq	$0x20, %rsi
               	imulq	$0x7, %rsi, %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rax
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
               	movl	$0xf, %eax
               	leaq	0x160(%rsp), %rdx
               	movzbq	0x60(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdi
               	andq	%rdi, %rax
               	movb	%al, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movzbq	(%rsi,%rax), %rdx
               	andq	$0xf, %rdx
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
               	leaq	0x60(%rsp), %rsi
               	movl	$0xf0, %eax
               	leaq	0x160(%rsp), %rdx
               	movzbq	0x60(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdi
               	orq	%rax, %rdi
               	movb	%dil, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdi
               	orq	%rdi, %rax
               	movb	%al, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movzbq	(%rsi,%rax), %rdx
               	orq	$0xf0, %rdx
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
               	leaq	0x60(%rsp), %rsi
               	movl	$0x55, %eax
               	leaq	0x160(%rsp), %rdx
               	movzbq	0x60(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdi
               	xorq	%rax, %rdi
               	movb	%dil, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdi
               	xorq	%rdi, %rax
               	movb	%al, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movzbq	(%rsi,%rax), %rdx
               	xorq	$0x55, %rdx
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
               	leaq	0x80(%rsp), %rsi
               	leaq	0x160(%rsp), %rax
               	movsbq	0x80(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x160(%rsp)
               	movsbq	0x81(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x161(%rsp)
               	movsbq	0x82(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x162(%rsp)
               	movsbq	0x83(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x163(%rsp)
               	movsbq	0x84(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x164(%rsp)
               	movsbq	0x85(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x165(%rsp)
               	movsbq	0x86(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x166(%rsp)
               	movsbq	0x87(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x167(%rsp)
               	movsbq	0x88(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x168(%rsp)
               	movsbq	0x89(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x169(%rsp)
               	movsbq	0x8a(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movsbq	0x8b(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movsbq	0x8c(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movsbq	0x8d(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movsbq	0x8e(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movsbq	0x8f(%rsp), %rdx
               	subq	$0x64, %rdx
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	xorl	%eax, %eax
               	movsbq	(%rsi,%rax), %rdx
               	subq	$0x64, %rdx
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
               	leaq	0x160(%rsp), %rdx
               	movsbq	0x80(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x160(%rsp)
               	movsbq	0x81(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x161(%rsp)
               	movsbq	0x82(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x162(%rsp)
               	movsbq	0x83(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x163(%rsp)
               	movsbq	0x84(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x164(%rsp)
               	movsbq	0x85(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x165(%rsp)
               	movsbq	0x86(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x166(%rsp)
               	movsbq	0x87(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x167(%rsp)
               	movsbq	0x88(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x168(%rsp)
               	movsbq	0x89(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x169(%rsp)
               	movsbq	0x8a(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x16a(%rsp)
               	movsbq	0x8b(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x16b(%rsp)
               	movsbq	0x8c(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x16c(%rsp)
               	movsbq	0x8d(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x16d(%rsp)
               	movsbq	0x8e(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x16e(%rsp)
               	movsbq	0x8f(%rsp), %rax
               	imulq	$0x55555556, %rax, %rax # imm = 0x55555556
               	sarq	$0x20, %rax
               	movq	%rax, %rsi
               	shrq	$0x3f, %rsi
               	addq	%rsi, %rax
               	movb	%al, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rax
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
               	leaq	0x80(%rsp), %r8
               	leaq	0x160(%rsp), %rsi
               	movsbq	0x80(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x160(%rsp)
               	movsbq	0x81(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x161(%rsp)
               	movsbq	0x82(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x162(%rsp)
               	movsbq	0x83(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x163(%rsp)
               	movsbq	0x84(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x164(%rsp)
               	movsbq	0x85(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x165(%rsp)
               	movsbq	0x86(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x166(%rsp)
               	movsbq	0x87(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x167(%rsp)
               	movsbq	0x88(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x168(%rsp)
               	movsbq	0x89(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x169(%rsp)
               	movsbq	0x8a(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x16a(%rsp)
               	movsbq	0x8b(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x16b(%rsp)
               	movsbq	0x8c(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x16c(%rsp)
               	movsbq	0x8d(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x16d(%rsp)
               	movsbq	0x8e(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x16e(%rsp)
               	movsbq	0x8f(%rsp), %rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	sarq	$0x20, %rdx
               	movq	%rdx, %rdi
               	shrq	$0x3f, %rdi
               	addq	%rdi, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	movb	%al, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rax
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
               	leaq	0xa0(%rsp), %rdi
               	movl	$0x3e8, %eax            # imm = 0x3E8
               	leaq	0x160(%rsp), %rdx
               	movzwq	0xa0(%rsp), %rsi
               	imulq	%rax, %rsi
               	movw	%si, 0x160(%rsp)
               	movzwq	0xa2(%rsp), %rsi
               	imulq	%rax, %rsi
               	movw	%si, 0x162(%rsp)
               	movzwq	0xa4(%rsp), %rsi
               	imulq	%rax, %rsi
               	movw	%si, 0x164(%rsp)
               	movzwq	0xa6(%rsp), %rsi
               	imulq	%rax, %rsi
               	movw	%si, 0x166(%rsp)
               	movzwq	0xa8(%rsp), %rsi
               	imulq	%rax, %rsi
               	movw	%si, 0x168(%rsp)
               	movzwq	0xaa(%rsp), %rsi
               	imulq	%rax, %rsi
               	movw	%si, 0x16a(%rsp)
               	movzwq	0xac(%rsp), %rsi
               	imulq	%rax, %rsi
               	movw	%si, 0x16c(%rsp)
               	movzwq	0xae(%rsp), %rsi
               	imulq	%rsi, %rax
               	movw	%ax, 0x16e(%rsp)
               	leaq	0x40(%rsp), %rax
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
               	leaq	0x140(%rsp), %rdi
               	movl	$0x7, %eax
               	movq	0x140(%rsp), %rdx
               	imulq	%rax, %rdx
               	movq	0x148(%rsp), %rsi
               	imulq	%rsi, %rax
               	movq	%rdx, 0x160(%rsp)
               	movq	%rax, 0x168(%rsp)
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
               	movl	$0x40, %eax
               	leaq	0x60(%rsp), %rdi
               	leaq	0x160(%rsp), %rdx
               	movzbq	0x60(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rax
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
               	movl	$0x64, %eax
               	leaq	0x80(%rsp), %rdi
               	leaq	0x160(%rsp), %rdx
               	movsbq	0x80(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x160(%rsp)
               	movsbq	0x81(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x161(%rsp)
               	movsbq	0x82(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x162(%rsp)
               	movsbq	0x83(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x163(%rsp)
               	movsbq	0x84(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x164(%rsp)
               	movsbq	0x85(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x165(%rsp)
               	movsbq	0x86(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x166(%rsp)
               	movsbq	0x87(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x167(%rsp)
               	movsbq	0x88(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x168(%rsp)
               	movsbq	0x89(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x169(%rsp)
               	movsbq	0x8a(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x16a(%rsp)
               	movsbq	0x8b(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x16b(%rsp)
               	movsbq	0x8c(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x16c(%rsp)
               	movsbq	0x8d(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x16d(%rsp)
               	movsbq	0x8e(%rsp), %rsi
               	movq	%rax, %r8
               	subq	%rsi, %r8
               	movb	%r8b, 0x16e(%rsp)
               	movsbq	0x8f(%rsp), %rsi
               	subq	%rsi, %rax
               	movb	%al, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rax
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
               	movl	$0xfa, %ecx
               	leaq	0x70(%rsp), %r8
               	leaq	0x160(%rsp), %rdi
               	movzbq	0x70(%rsp), %r9
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movb	%al, 0x160(%rsp)
               	movzbq	0x71(%rsp), %r9
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movb	%al, 0x161(%rsp)
               	movzbq	0x72(%rsp), %r9
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movb	%al, 0x162(%rsp)
               	movzbq	0x73(%rsp), %r9
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movb	%al, 0x163(%rsp)
               	movzbq	0x74(%rsp), %r9
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movb	%al, 0x164(%rsp)
               	movzbq	0x75(%rsp), %r9
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movb	%al, 0x165(%rsp)
               	movzbq	0x76(%rsp), %r9
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movb	%al, 0x166(%rsp)
               	movzbq	0x77(%rsp), %r9
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movb	%al, 0x167(%rsp)
               	movzbq	0x78(%rsp), %r9
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movb	%al, 0x168(%rsp)
               	movzbq	0x79(%rsp), %r9
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movb	%al, 0x169(%rsp)
               	movzbq	0x7a(%rsp), %r9
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movb	%al, 0x16a(%rsp)
               	movzbq	0x7b(%rsp), %r9
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movb	%al, 0x16b(%rsp)
               	movzbq	0x7c(%rsp), %r9
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movb	%al, 0x16c(%rsp)
               	movzbq	0x7d(%rsp), %r9
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movb	%al, 0x16d(%rsp)
               	movzbq	0x7e(%rsp), %r9
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movb	%al, 0x16e(%rsp)
               	movzbq	0x7f(%rsp), %r9
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r9
               	movb	%al, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xfa, %eax
               	movzbq	(%r8,%rcx), %rdi
               	cqto
               	idivq	%rdi
               	andq	$0xff, %rax
               	movb	%al, (%rsi,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
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
               	movl	$0xfa, %ecx
               	leaq	0x70(%rsp), %r9
               	leaq	0x160(%rsp), %rdi
               	movzbq	0x70(%rsp), %r8
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x71(%rsp), %r8
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x72(%rsp), %r8
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x73(%rsp), %r8
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x74(%rsp), %r8
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x75(%rsp), %r8
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x76(%rsp), %r8
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x77(%rsp), %r8
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x78(%rsp), %r8
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x79(%rsp), %r8
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x7a(%rsp), %r8
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x7b(%rsp), %r8
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x7c(%rsp), %r8
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x7d(%rsp), %r8
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x7e(%rsp), %r8
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x7f(%rsp), %r8
               	movq	%rcx, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movl	$0xfa, %edi
               	movzbq	(%r9,%rcx), %r8
               	movq	%rdi, %rax
               	cqto
               	idivq	%r8
               	movq	%rdx, %rax
               	andq	$0xff, %rax
               	movb	%al, (%rsi,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
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
               	movl	$0xf, %eax
               	leaq	0x70(%rsp), %rsi
               	leaq	0x160(%rsp), %rdx
               	movzbq	0x70(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x160(%rsp)
               	movzbq	0x71(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x161(%rsp)
               	movzbq	0x72(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x162(%rsp)
               	movzbq	0x73(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x163(%rsp)
               	movzbq	0x74(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x164(%rsp)
               	movzbq	0x75(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x165(%rsp)
               	movzbq	0x76(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x166(%rsp)
               	movzbq	0x77(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x167(%rsp)
               	movzbq	0x78(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x168(%rsp)
               	movzbq	0x79(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x169(%rsp)
               	movzbq	0x7a(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x16a(%rsp)
               	movzbq	0x7b(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x16b(%rsp)
               	movzbq	0x7c(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x16c(%rsp)
               	movzbq	0x7d(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x16d(%rsp)
               	movzbq	0x7e(%rsp), %rdi
               	andq	%rax, %rdi
               	movb	%dil, 0x16e(%rsp)
               	movzbq	0x7f(%rsp), %rdi
               	andq	%rdi, %rax
               	movb	%al, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%eax, %eax
               	movzbq	(%rsi,%rax), %rdx
               	andq	$0xf, %rdx
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
               	movl	$0x3, %eax
               	leaq	(%rsp), %rdi
               	leaq	0x160(%rsp), %rdx
               	movzbq	(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x160(%rsp)
               	movzbq	0x1(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x161(%rsp)
               	movzbq	0x2(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x162(%rsp)
               	movzbq	0x3(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x163(%rsp)
               	movzbq	0x4(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x164(%rsp)
               	movzbq	0x5(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x165(%rsp)
               	movzbq	0x6(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x166(%rsp)
               	movzbq	0x7(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x167(%rsp)
               	movzbq	0x8(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x168(%rsp)
               	movzbq	0x9(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x169(%rsp)
               	movzbq	0xa(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x16a(%rsp)
               	movzbq	0xb(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x16b(%rsp)
               	movzbq	0xc(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x16c(%rsp)
               	movzbq	0xd(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x16d(%rsp)
               	movzbq	0xe(%rsp), %rsi
               	shlxq	%rsi, %rax, %rsi
               	movb	%sil, 0x16e(%rsp)
               	movzbq	0xf(%rsp), %rsi
               	shlxq	%rsi, %rax, %rax
               	movb	%al, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rax
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
               	movl	$0x80, %eax
               	leaq	(%rsp), %rdi
               	leaq	0x160(%rsp), %rdx
               	movzbq	(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x160(%rsp)
               	movzbq	0x1(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x161(%rsp)
               	movzbq	0x2(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x162(%rsp)
               	movzbq	0x3(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x163(%rsp)
               	movzbq	0x4(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x164(%rsp)
               	movzbq	0x5(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x165(%rsp)
               	movzbq	0x6(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x166(%rsp)
               	movzbq	0x7(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x167(%rsp)
               	movzbq	0x8(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x168(%rsp)
               	movzbq	0x9(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x169(%rsp)
               	movzbq	0xa(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x16a(%rsp)
               	movzbq	0xb(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x16b(%rsp)
               	movzbq	0xc(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x16c(%rsp)
               	movzbq	0xd(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x16d(%rsp)
               	movzbq	0xe(%rsp), %rsi
               	shrxq	%rsi, %rax, %rsi
               	movb	%sil, 0x16e(%rsp)
               	movzbq	0xf(%rsp), %rsi
               	shrxq	%rsi, %rax, %rax
               	movb	%al, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rax
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
               	movl	%edi, 0x160(%rsp)
               	movl	%r8d, 0x164(%rsp)
               	movl	%eax, 0x168(%rsp)
               	movl	%ecx, 0x16c(%rsp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rsi,%rdx), %rdi
               	movq	$-0x7, %rax
               	addq	%r9, %rdx
               	movslq	(%rdx), %r8
               	cqto
               	idivq	%r8
               	movl	%eax, (%rdi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
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
               	movl	%edi, 0x160(%rsp)
               	movl	%r8d, 0x164(%rsp)
               	movl	%r9d, 0x168(%rsp)
               	movl	%edx, 0x16c(%rsp)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rdx
               	shlq	$0x2, %rdx
               	leaq	(%rsi,%rdx), %rdi
               	movq	$-0x7, %r8
               	leaq	(%rbx,%rdx), %rax
               	movslq	(%rax), %r9
               	movq	%r8, %rax
               	cqto
               	idivq	%r9
               	movl	%edx, (%rdi)
               	incq	%rcx
               	cmpl	$0x4, %ecx
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
               	leaq	0x60(%rsp), %rsi
               	leaq	0x160(%rsp), %rax
               	movzbq	0x60(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	imulq	$0x55555556, %rdx, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rdx
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
               	movl	%edx, 0x160(%rsp)
               	movl	%esi, 0x164(%rsp)
               	movl	%edi, 0x168(%rsp)
               	movl	%eax, 0x16c(%rsp)
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
               	leaq	0x60(%rsp), %rsi
               	leaq	0x160(%rsp), %rdx
               	movzbq	0x60(%rsp), %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rdi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rdi)
               	movzbq	(%rsi,%rax), %rdx
               	negq	%rdx
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
               	leaq	0x80(%rsp), %rsi
               	leaq	0x160(%rsp), %rdx
               	movsbq	0x80(%rsp), %rdi
               	xorl	%eax, %eax
               	negq	%rdi
               	movb	%dil, 0x160(%rsp)
               	movsbq	0x81(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x161(%rsp)
               	movsbq	0x82(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x162(%rsp)
               	movsbq	0x83(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x163(%rsp)
               	movsbq	0x84(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x164(%rsp)
               	movsbq	0x85(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x165(%rsp)
               	movsbq	0x86(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x166(%rsp)
               	movsbq	0x87(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x167(%rsp)
               	movsbq	0x88(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x168(%rsp)
               	movsbq	0x89(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x169(%rsp)
               	movsbq	0x8a(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x16a(%rsp)
               	movsbq	0x8b(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x16b(%rsp)
               	movsbq	0x8c(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x16c(%rsp)
               	movsbq	0x8d(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x16d(%rsp)
               	movsbq	0x8e(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x16e(%rsp)
               	movsbq	0x8f(%rsp), %rdi
               	negq	%rdi
               	movb	%dil, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rdi
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rdi)
               	movsbq	(%rsi,%rax), %rdx
               	negq	%rdx
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
               	movl	%edx, 0x160(%rsp)
               	movl	%esi, 0x164(%rsp)
               	movl	%r8d, 0x168(%rsp)
               	movl	%r9d, 0x16c(%rsp)
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
               	leaq	0x60(%rsp), %rsi
               	leaq	0x160(%rsp), %rax
               	movzbq	0x60(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rdx
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
               	leaq	0x140(%rsp), %rdi
               	movq	0x140(%rsp), %rax
               	xorq	$-0x1, %rax
               	movq	0x148(%rsp), %rdx
               	xorq	$-0x1, %rdx
               	movq	%rax, 0x160(%rsp)
               	movq	%rdx, 0x168(%rsp)
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
               	leaq	0x60(%rsp), %rax
               	leaq	0x160(%rsp), %rcx
               	movzbq	0x60(%rsp), %rdx
               	movzbq	0x70(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	movzbq	0x71(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	movzbq	0x72(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	movzbq	0x73(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	movzbq	0x74(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	movzbq	0x75(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	movzbq	0x76(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	movzbq	0x77(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	movzbq	0x78(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	movzbq	0x79(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	movzbq	0x7a(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	movzbq	0x7b(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	movzbq	0x7c(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	movzbq	0x7d(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	movzbq	0x7e(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	movzbq	0x7f(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x160(%rsp), %rax
               	movzbq	0x40(%rsp), %rsi
               	movzbq	0x70(%rsp), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x160(%rsp)
               	movzbq	0x41(%rsp), %rsi
               	movzbq	0x71(%rsp), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x161(%rsp)
               	movzbq	0x42(%rsp), %rsi
               	movzbq	0x72(%rsp), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x162(%rsp)
               	movzbq	0x43(%rsp), %rsi
               	movzbq	0x73(%rsp), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x163(%rsp)
               	movzbq	0x44(%rsp), %rsi
               	movzbq	0x74(%rsp), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x164(%rsp)
               	movzbq	0x45(%rsp), %rsi
               	movzbq	0x75(%rsp), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x165(%rsp)
               	movzbq	0x46(%rsp), %rsi
               	movzbq	0x76(%rsp), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x166(%rsp)
               	movzbq	0x47(%rsp), %rsi
               	movzbq	0x77(%rsp), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x167(%rsp)
               	movzbq	0x48(%rsp), %rsi
               	movzbq	0x78(%rsp), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x168(%rsp)
               	movzbq	0x49(%rsp), %rsi
               	movzbq	0x79(%rsp), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x169(%rsp)
               	movzbq	0x4a(%rsp), %rsi
               	movzbq	0x7a(%rsp), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x16a(%rsp)
               	movzbq	0x4b(%rsp), %rsi
               	movzbq	0x7b(%rsp), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x16b(%rsp)
               	movzbq	0x4c(%rsp), %rsi
               	movzbq	0x7c(%rsp), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x16c(%rsp)
               	movzbq	0x4d(%rsp), %rsi
               	movzbq	0x7d(%rsp), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x16d(%rsp)
               	movzbq	0x4e(%rsp), %rsi
               	movzbq	0x7e(%rsp), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x16e(%rsp)
               	movzbq	0x4f(%rsp), %rsi
               	movzbq	0x7f(%rsp), %rdi
               	addq	%rdi, %rsi
               	movb	%sil, 0x16f(%rsp)
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
               	leaq	0x160(%rsp), %rcx
               	movzbq	0x60(%rsp), %rdx
               	movzbq	0x70(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	movzbq	0x71(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	movzbq	0x72(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	movzbq	0x73(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	movzbq	0x74(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	movzbq	0x75(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	movzbq	0x76(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	movzbq	0x77(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	movzbq	0x78(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	movzbq	0x79(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	movzbq	0x7a(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	movzbq	0x7b(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	movzbq	0x7c(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	movzbq	0x7d(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	movzbq	0x7e(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	movzbq	0x7f(%rsp), %rsi
               	subq	%rsi, %rdx
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x160(%rsp), %rax
               	movzbq	0x40(%rsp), %rsi
               	movzbq	0x70(%rsp), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x160(%rsp)
               	movzbq	0x41(%rsp), %rsi
               	movzbq	0x71(%rsp), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x161(%rsp)
               	movzbq	0x42(%rsp), %rsi
               	movzbq	0x72(%rsp), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x162(%rsp)
               	movzbq	0x43(%rsp), %rsi
               	movzbq	0x73(%rsp), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x163(%rsp)
               	movzbq	0x44(%rsp), %rsi
               	movzbq	0x74(%rsp), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x164(%rsp)
               	movzbq	0x45(%rsp), %rsi
               	movzbq	0x75(%rsp), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x165(%rsp)
               	movzbq	0x46(%rsp), %rsi
               	movzbq	0x76(%rsp), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x166(%rsp)
               	movzbq	0x47(%rsp), %rsi
               	movzbq	0x77(%rsp), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x167(%rsp)
               	movzbq	0x48(%rsp), %rsi
               	movzbq	0x78(%rsp), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x168(%rsp)
               	movzbq	0x49(%rsp), %rsi
               	movzbq	0x79(%rsp), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x169(%rsp)
               	movzbq	0x4a(%rsp), %rsi
               	movzbq	0x7a(%rsp), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x16a(%rsp)
               	movzbq	0x4b(%rsp), %rsi
               	movzbq	0x7b(%rsp), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x16b(%rsp)
               	movzbq	0x4c(%rsp), %rsi
               	movzbq	0x7c(%rsp), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x16c(%rsp)
               	movzbq	0x4d(%rsp), %rsi
               	movzbq	0x7d(%rsp), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x16d(%rsp)
               	movzbq	0x4e(%rsp), %rsi
               	movzbq	0x7e(%rsp), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x16e(%rsp)
               	movzbq	0x4f(%rsp), %rsi
               	movzbq	0x7f(%rsp), %rdi
               	subq	%rdi, %rsi
               	movb	%sil, 0x16f(%rsp)
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
               	leaq	0x160(%rsp), %rcx
               	movzbq	0x60(%rsp), %rdx
               	movzbq	0x70(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	movzbq	0x71(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	movzbq	0x72(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	movzbq	0x73(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	movzbq	0x74(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	movzbq	0x75(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	movzbq	0x76(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	movzbq	0x77(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	movzbq	0x78(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	movzbq	0x79(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	movzbq	0x7a(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	movzbq	0x7b(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	movzbq	0x7c(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	movzbq	0x7d(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	movzbq	0x7e(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	movzbq	0x7f(%rsp), %rsi
               	imulq	%rsi, %rdx
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x160(%rsp), %rax
               	movzbq	0x40(%rsp), %rsi
               	movzbq	0x70(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x160(%rsp)
               	movzbq	0x41(%rsp), %rsi
               	movzbq	0x71(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x161(%rsp)
               	movzbq	0x42(%rsp), %rsi
               	movzbq	0x72(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x162(%rsp)
               	movzbq	0x43(%rsp), %rsi
               	movzbq	0x73(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x163(%rsp)
               	movzbq	0x44(%rsp), %rsi
               	movzbq	0x74(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x164(%rsp)
               	movzbq	0x45(%rsp), %rsi
               	movzbq	0x75(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x165(%rsp)
               	movzbq	0x46(%rsp), %rsi
               	movzbq	0x76(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x166(%rsp)
               	movzbq	0x47(%rsp), %rsi
               	movzbq	0x77(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x167(%rsp)
               	movzbq	0x48(%rsp), %rsi
               	movzbq	0x78(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x168(%rsp)
               	movzbq	0x49(%rsp), %rsi
               	movzbq	0x79(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x169(%rsp)
               	movzbq	0x4a(%rsp), %rsi
               	movzbq	0x7a(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x16a(%rsp)
               	movzbq	0x4b(%rsp), %rsi
               	movzbq	0x7b(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x16b(%rsp)
               	movzbq	0x4c(%rsp), %rsi
               	movzbq	0x7c(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x16c(%rsp)
               	movzbq	0x4d(%rsp), %rsi
               	movzbq	0x7d(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x16d(%rsp)
               	movzbq	0x4e(%rsp), %rsi
               	movzbq	0x7e(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x16e(%rsp)
               	movzbq	0x4f(%rsp), %rsi
               	movzbq	0x7f(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movb	%sil, 0x16f(%rsp)
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
               	leaq	0x160(%rsp), %rcx
               	movzbq	0x60(%rsp), %rax
               	movzbq	0x70(%rsp), %rsi
               	xorl	%edx, %edx
               	divq	%rsi
               	movb	%al, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rax
               	movzbq	0x71(%rsp), %rsi
               	xorl	%edx, %edx
               	divq	%rsi
               	movb	%al, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rax
               	movzbq	0x72(%rsp), %rsi
               	xorl	%edx, %edx
               	divq	%rsi
               	movb	%al, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rax
               	movzbq	0x73(%rsp), %rsi
               	xorl	%edx, %edx
               	divq	%rsi
               	movb	%al, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rax
               	movzbq	0x74(%rsp), %rsi
               	xorl	%edx, %edx
               	divq	%rsi
               	movb	%al, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rax
               	movzbq	0x75(%rsp), %rsi
               	xorl	%edx, %edx
               	divq	%rsi
               	movb	%al, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rax
               	movzbq	0x76(%rsp), %rsi
               	xorl	%edx, %edx
               	divq	%rsi
               	movb	%al, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rax
               	movzbq	0x77(%rsp), %rsi
               	xorl	%edx, %edx
               	divq	%rsi
               	movb	%al, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rax
               	movzbq	0x78(%rsp), %rsi
               	xorl	%edx, %edx
               	divq	%rsi
               	movb	%al, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rax
               	movzbq	0x79(%rsp), %rsi
               	xorl	%edx, %edx
               	divq	%rsi
               	movb	%al, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rax
               	movzbq	0x7a(%rsp), %rsi
               	xorl	%edx, %edx
               	divq	%rsi
               	movb	%al, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rax
               	movzbq	0x7b(%rsp), %rsi
               	xorl	%edx, %edx
               	divq	%rsi
               	movb	%al, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rax
               	movzbq	0x7c(%rsp), %rsi
               	xorl	%edx, %edx
               	divq	%rsi
               	movb	%al, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rax
               	movzbq	0x7d(%rsp), %rsi
               	xorl	%edx, %edx
               	divq	%rsi
               	movb	%al, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rax
               	movzbq	0x7e(%rsp), %rsi
               	xorl	%edx, %edx
               	divq	%rsi
               	movb	%al, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rax
               	movzbq	0x7f(%rsp), %rsi
               	xorl	%edx, %edx
               	divq	%rsi
               	movb	%al, 0x16f(%rsp)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x160(%rsp), %rdi
               	movzbq	0x40(%rsp), %rax
               	movzbq	0x70(%rsp), %r8
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%al, 0x160(%rsp)
               	movzbq	0x41(%rsp), %rax
               	movzbq	0x71(%rsp), %r8
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%al, 0x161(%rsp)
               	movzbq	0x42(%rsp), %rax
               	movzbq	0x72(%rsp), %r8
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%al, 0x162(%rsp)
               	movzbq	0x43(%rsp), %rax
               	movzbq	0x73(%rsp), %r8
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%al, 0x163(%rsp)
               	movzbq	0x44(%rsp), %rax
               	movzbq	0x74(%rsp), %r8
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%al, 0x164(%rsp)
               	movzbq	0x45(%rsp), %rax
               	movzbq	0x75(%rsp), %r8
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%al, 0x165(%rsp)
               	movzbq	0x46(%rsp), %rax
               	movzbq	0x76(%rsp), %r8
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%al, 0x166(%rsp)
               	movzbq	0x47(%rsp), %rax
               	movzbq	0x77(%rsp), %r8
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%al, 0x167(%rsp)
               	movzbq	0x48(%rsp), %rax
               	movzbq	0x78(%rsp), %r8
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%al, 0x168(%rsp)
               	movzbq	0x49(%rsp), %rax
               	movzbq	0x79(%rsp), %r8
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%al, 0x169(%rsp)
               	movzbq	0x4a(%rsp), %rax
               	movzbq	0x7a(%rsp), %r8
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%al, 0x16a(%rsp)
               	movzbq	0x4b(%rsp), %rax
               	movzbq	0x7b(%rsp), %r8
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%al, 0x16b(%rsp)
               	movzbq	0x4c(%rsp), %rax
               	movzbq	0x7c(%rsp), %r8
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%al, 0x16c(%rsp)
               	movzbq	0x4d(%rsp), %rax
               	movzbq	0x7d(%rsp), %r8
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%al, 0x16d(%rsp)
               	movzbq	0x4e(%rsp), %rax
               	movzbq	0x7e(%rsp), %r8
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%al, 0x16e(%rsp)
               	movzbq	0x4f(%rsp), %rax
               	movzbq	0x7f(%rsp), %r8
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%al, 0x16f(%rsp)
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
               	leaq	0x160(%rsp), %rcx
               	movzbq	0x60(%rsp), %rdi
               	movzbq	0x70(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdi
               	movzbq	0x71(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdi
               	movzbq	0x72(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdi
               	movzbq	0x73(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdi
               	movzbq	0x74(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdi
               	movzbq	0x75(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdi
               	movzbq	0x76(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdi
               	movzbq	0x77(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdi
               	movzbq	0x78(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdi
               	movzbq	0x79(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdi
               	movzbq	0x7a(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdi
               	movzbq	0x7b(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdi
               	movzbq	0x7c(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdi
               	movzbq	0x7d(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdi
               	movzbq	0x7e(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdi
               	movzbq	0x7f(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x20(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x160(%rsp), %rsi
               	movzbq	0x40(%rsp), %rdi
               	movzbq	0x70(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x41(%rsp), %rdi
               	movzbq	0x71(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x42(%rsp), %rdi
               	movzbq	0x72(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x43(%rsp), %rdi
               	movzbq	0x73(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x44(%rsp), %rdi
               	movzbq	0x74(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x45(%rsp), %rdi
               	movzbq	0x75(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x46(%rsp), %rdi
               	movzbq	0x76(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x47(%rsp), %rdi
               	movzbq	0x77(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x48(%rsp), %rdi
               	movzbq	0x78(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x49(%rsp), %rdi
               	movzbq	0x79(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x4a(%rsp), %rdi
               	movzbq	0x7a(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x4b(%rsp), %rdi
               	movzbq	0x7b(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x4c(%rsp), %rdi
               	movzbq	0x7c(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x4d(%rsp), %rdi
               	movzbq	0x7d(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x4e(%rsp), %rdi
               	movzbq	0x7e(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x4f(%rsp), %rdi
               	movzbq	0x7f(%rsp), %r8
               	movq	%rdi, %rax
               	xorl	%edx, %edx
               	divq	%r8
               	movb	%dl, 0x16f(%rsp)
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x20(%rsp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	movq	0x60(%rsp), %rcx
               	movq	0x70(%rsp), %rdx
               	andq	%rdx, %rcx
               	movq	0x68(%rsp), %rdx
               	movq	0x78(%rsp), %rsi
               	andq	%rdx, %rsi
               	leaq	0x40(%rsp), %rdx
               	movq	%rcx, 0x40(%rsp)
               	movq	%rsi, 0x48(%rsp)
               	leaq	0x160(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	0x160(%rsp), %rax
               	movq	0x70(%rsp), %rsi
               	andq	%rsi, %rax
               	movq	0x168(%rsp), %rsi
               	movq	0x78(%rsp), %rdi
               	andq	%rdi, %rsi
               	movq	%rax, 0x160(%rsp)
               	movq	%rsi, 0x168(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	movq	0x60(%rsp), %rcx
               	movq	0x70(%rsp), %rdx
               	orq	%rdx, %rcx
               	movq	0x68(%rsp), %rdx
               	movq	0x78(%rsp), %rsi
               	orq	%rdx, %rsi
               	leaq	0x40(%rsp), %rdx
               	movq	%rcx, 0x40(%rsp)
               	movq	%rsi, 0x48(%rsp)
               	leaq	0x160(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	0x160(%rsp), %rax
               	movq	0x70(%rsp), %rsi
               	orq	%rsi, %rax
               	movq	0x168(%rsp), %rsi
               	movq	0x78(%rsp), %rdi
               	orq	%rdi, %rsi
               	movq	%rax, 0x160(%rsp)
               	movq	%rsi, 0x168(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	movq	0x60(%rsp), %rcx
               	movq	0x70(%rsp), %rdx
               	xorq	%rdx, %rcx
               	movq	0x68(%rsp), %rdx
               	movq	0x78(%rsp), %rsi
               	xorq	%rdx, %rsi
               	leaq	0x40(%rsp), %rdx
               	movq	%rcx, 0x40(%rsp)
               	movq	%rsi, 0x48(%rsp)
               	leaq	0x160(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	0x160(%rsp), %rax
               	movq	0x70(%rsp), %rsi
               	xorq	%rsi, %rax
               	movq	0x168(%rsp), %rsi
               	movq	0x78(%rsp), %rdi
               	xorq	%rdi, %rsi
               	movq	%rax, 0x160(%rsp)
               	movq	%rsi, 0x168(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	leaq	0x160(%rsp), %rcx
               	movzbq	0x60(%rsp), %rdx
               	movzbq	(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	movzbq	0x1(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	movzbq	0x2(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	movzbq	0x3(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	movzbq	0x4(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	movzbq	0x5(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	movzbq	0x6(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	movzbq	0x7(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	movzbq	0x8(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	movzbq	0x9(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	movzbq	0xa(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	movzbq	0xb(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	movzbq	0xc(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	movzbq	0xd(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	movzbq	0xe(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	movzbq	0xf(%rsp), %rsi
               	shlxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x160(%rsp), %rax
               	movzbq	0x40(%rsp), %rsi
               	movzbq	(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x160(%rsp)
               	movzbq	0x41(%rsp), %rsi
               	movzbq	0x1(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x161(%rsp)
               	movzbq	0x42(%rsp), %rsi
               	movzbq	0x2(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x162(%rsp)
               	movzbq	0x43(%rsp), %rsi
               	movzbq	0x3(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x163(%rsp)
               	movzbq	0x44(%rsp), %rsi
               	movzbq	0x4(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x164(%rsp)
               	movzbq	0x45(%rsp), %rsi
               	movzbq	0x5(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x165(%rsp)
               	movzbq	0x46(%rsp), %rsi
               	movzbq	0x6(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x166(%rsp)
               	movzbq	0x47(%rsp), %rsi
               	movzbq	0x7(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x167(%rsp)
               	movzbq	0x48(%rsp), %rsi
               	movzbq	0x8(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x168(%rsp)
               	movzbq	0x49(%rsp), %rsi
               	movzbq	0x9(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x169(%rsp)
               	movzbq	0x4a(%rsp), %rsi
               	movzbq	0xa(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x16a(%rsp)
               	movzbq	0x4b(%rsp), %rsi
               	movzbq	0xb(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x16b(%rsp)
               	movzbq	0x4c(%rsp), %rsi
               	movzbq	0xc(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x16c(%rsp)
               	movzbq	0x4d(%rsp), %rsi
               	movzbq	0xd(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x16d(%rsp)
               	movzbq	0x4e(%rsp), %rsi
               	movzbq	0xe(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x16e(%rsp)
               	movzbq	0x4f(%rsp), %rsi
               	movzbq	0xf(%rsp), %rdi
               	shlxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x16f(%rsp)
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
               	leaq	0x160(%rsp), %rcx
               	movzbq	0x60(%rsp), %rdx
               	movzbq	(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	movzbq	0x1(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	movzbq	0x2(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	movzbq	0x3(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	movzbq	0x4(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	movzbq	0x5(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	movzbq	0x6(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	movzbq	0x7(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	movzbq	0x8(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	movzbq	0x9(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	movzbq	0xa(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	movzbq	0xb(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	movzbq	0xc(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	movzbq	0xd(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	movzbq	0xe(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	movzbq	0xf(%rsp), %rsi
               	shrxq	%rsi, %rdx, %rdx
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x160(%rsp), %rax
               	movzbq	0x40(%rsp), %rsi
               	movzbq	(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x160(%rsp)
               	movzbq	0x41(%rsp), %rsi
               	movzbq	0x1(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x161(%rsp)
               	movzbq	0x42(%rsp), %rsi
               	movzbq	0x2(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x162(%rsp)
               	movzbq	0x43(%rsp), %rsi
               	movzbq	0x3(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x163(%rsp)
               	movzbq	0x44(%rsp), %rsi
               	movzbq	0x4(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x164(%rsp)
               	movzbq	0x45(%rsp), %rsi
               	movzbq	0x5(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x165(%rsp)
               	movzbq	0x46(%rsp), %rsi
               	movzbq	0x6(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x166(%rsp)
               	movzbq	0x47(%rsp), %rsi
               	movzbq	0x7(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x167(%rsp)
               	movzbq	0x48(%rsp), %rsi
               	movzbq	0x8(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x168(%rsp)
               	movzbq	0x49(%rsp), %rsi
               	movzbq	0x9(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x169(%rsp)
               	movzbq	0x4a(%rsp), %rsi
               	movzbq	0xa(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x16a(%rsp)
               	movzbq	0x4b(%rsp), %rsi
               	movzbq	0xb(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x16b(%rsp)
               	movzbq	0x4c(%rsp), %rsi
               	movzbq	0xc(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x16c(%rsp)
               	movzbq	0x4d(%rsp), %rsi
               	movzbq	0xd(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x16d(%rsp)
               	movzbq	0x4e(%rsp), %rsi
               	movzbq	0xe(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x16e(%rsp)
               	movzbq	0x4f(%rsp), %rsi
               	movzbq	0xf(%rsp), %rdi
               	shrxq	%rdi, %rsi, %rsi
               	movb	%sil, 0x16f(%rsp)
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
               	leaq	0x160(%rsp), %rcx
               	movswq	0xc0(%rsp), %rax
               	movswq	0xd0(%rsp), %rsi
               	cqto
               	idivq	%rsi
               	movw	%ax, 0x160(%rsp)
               	movswq	0xc2(%rsp), %rax
               	movswq	0xd2(%rsp), %rsi
               	cqto
               	idivq	%rsi
               	movw	%ax, 0x162(%rsp)
               	movswq	0xc4(%rsp), %rax
               	movswq	0xd4(%rsp), %rsi
               	cqto
               	idivq	%rsi
               	movw	%ax, 0x164(%rsp)
               	movswq	0xc6(%rsp), %rax
               	movswq	0xd6(%rsp), %rsi
               	cqto
               	idivq	%rsi
               	movw	%ax, 0x166(%rsp)
               	movswq	0xc8(%rsp), %rax
               	movswq	0xd8(%rsp), %rsi
               	cqto
               	idivq	%rsi
               	movw	%ax, 0x168(%rsp)
               	movswq	0xca(%rsp), %rax
               	movswq	0xda(%rsp), %rsi
               	cqto
               	idivq	%rsi
               	movw	%ax, 0x16a(%rsp)
               	movswq	0xcc(%rsp), %rax
               	movswq	0xdc(%rsp), %rsi
               	cqto
               	idivq	%rsi
               	movw	%ax, 0x16c(%rsp)
               	movswq	0xce(%rsp), %rax
               	movswq	0xde(%rsp), %rsi
               	cqto
               	idivq	%rsi
               	movw	%ax, 0x16e(%rsp)
               	leaq	0x20(%rsp), %rsi
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x160(%rsp), %rdi
               	movswq	0x40(%rsp), %rax
               	movswq	0xd0(%rsp), %r8
               	cqto
               	idivq	%r8
               	movw	%ax, 0x160(%rsp)
               	movswq	0x42(%rsp), %rax
               	movswq	0xd2(%rsp), %r8
               	cqto
               	idivq	%r8
               	movw	%ax, 0x162(%rsp)
               	movswq	0x44(%rsp), %rax
               	movswq	0xd4(%rsp), %r8
               	cqto
               	idivq	%r8
               	movw	%ax, 0x164(%rsp)
               	movswq	0x46(%rsp), %rax
               	movswq	0xd6(%rsp), %r8
               	cqto
               	idivq	%r8
               	movw	%ax, 0x166(%rsp)
               	movswq	0x48(%rsp), %rax
               	movswq	0xd8(%rsp), %r8
               	cqto
               	idivq	%r8
               	movw	%ax, 0x168(%rsp)
               	movswq	0x4a(%rsp), %rax
               	movswq	0xda(%rsp), %r8
               	cqto
               	idivq	%r8
               	movw	%ax, 0x16a(%rsp)
               	movswq	0x4c(%rsp), %rax
               	movswq	0xdc(%rsp), %r8
               	cqto
               	idivq	%r8
               	movw	%ax, 0x16c(%rsp)
               	movswq	0x4e(%rsp), %rax
               	movswq	0xde(%rsp), %r8
               	cqto
               	idivq	%r8
               	movw	%ax, 0x16e(%rsp)
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
               	leaq	0x40(%rsp), %rdx
               	movq	%rcx, 0x40(%rsp)
               	movq	%rsi, 0x48(%rsp)
               	leaq	0x160(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movq	0x160(%rsp), %rax
               	movq	0x150(%rsp), %rsi
               	imulq	%rsi, %rax
               	movq	0x168(%rsp), %rsi
               	movq	0x158(%rsp), %rdi
               	imulq	%rdi, %rsi
               	movq	%rax, 0x160(%rsp)
               	movq	%rsi, 0x168(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x160(%rsp), %rax
               	movzbq	0x20(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x21(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x22(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x23(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x24(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x25(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x26(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x27(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x28(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x29(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x2a(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x2b(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x2c(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x2d(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x2e(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x2f(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16f(%rsp)
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x160(%rsp), %rax
               	movzbq	0x60(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rdx
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
               	leaq	0x40(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x160(%rsp), %rcx
               	movzbq	0x40(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x41(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x42(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x43(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x44(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x45(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x46(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x47(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x48(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x49(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x4a(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x4b(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x4c(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x4d(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x4e(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x4f(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16f(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x160(%rsp), %rcx
               	movzbq	0x40(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x41(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x42(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x43(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x44(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x45(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x46(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x47(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x48(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x49(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x4a(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x4b(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x4c(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x4d(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x4e(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x4f(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16f(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x160(%rsp), %rcx
               	movzbq	0x40(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x41(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x42(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x43(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x44(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x45(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x46(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x47(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x48(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x49(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x4a(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x4b(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x4c(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x4d(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x4e(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x4f(%rsp), %rdx
               	subq	$0x40, %rdx
               	movb	%dl, 0x16f(%rsp)
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
               	movzbq	0x60(%rsp), %rax
               	movzbq	0x70(%rsp), %rcx
               	addq	%rax, %rcx
               	movzbq	0x61(%rsp), %rax
               	movzbq	0x71(%rsp), %rdx
               	addq	%rax, %rdx
               	movzbq	0x62(%rsp), %rax
               	movzbq	0x72(%rsp), %rsi
               	addq	%rax, %rsi
               	movzbq	0x63(%rsp), %rax
               	movzbq	0x73(%rsp), %rdi
               	addq	%rax, %rdi
               	movzbq	0x64(%rsp), %rax
               	movzbq	0x74(%rsp), %r8
               	addq	%rax, %r8
               	movzbq	0x65(%rsp), %rax
               	movzbq	0x75(%rsp), %r9
               	addq	%rax, %r9
               	movzbq	0x66(%rsp), %rax
               	movzbq	0x76(%rsp), %rbx
               	addq	%rax, %rbx
               	movzbq	0x67(%rsp), %rax
               	movzbq	0x77(%rsp), %r12
               	addq	%rax, %r12
               	movzbq	0x68(%rsp), %rax
               	movzbq	0x78(%rsp), %r13
               	addq	%rax, %r13
               	movzbq	0x69(%rsp), %rax
               	movzbq	0x79(%rsp), %r14
               	addq	%rax, %r14
               	movzbq	0x6a(%rsp), %rax
               	movzbq	0x7a(%rsp), %r15
               	addq	%rax, %r15
               	movzbq	0x6b(%rsp), %rax
               	movzbq	0x7b(%rsp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	%rax, %r10
               	addq	-0x48(%rbp), %r10
               	movq	%r10, -0x48(%rbp)
               	movzbq	0x6c(%rsp), %rax
               	movzbq	0x7c(%rsp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	%rax, %r10
               	addq	-0x50(%rbp), %r10
               	movq	%r10, -0x50(%rbp)
               	movzbq	0x6d(%rsp), %rax
               	movzbq	0x7d(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	movq	%rax, %r10
               	addq	-0x58(%rbp), %r10
               	movq	%r10, -0x58(%rbp)
               	movzbq	0x6e(%rsp), %rax
               	movzbq	0x7e(%rsp), %r10
               	movq	%r10, -0x60(%rbp)
               	movq	%rax, %r10
               	addq	-0x60(%rbp), %r10
               	movq	%r10, -0x60(%rbp)
               	movzbq	0x6f(%rsp), %rax
               	movzbq	0x7f(%rsp), %r10
               	movq	%r10, -0x68(%rbp)
               	movq	%rax, %r10
               	addq	-0x68(%rbp), %r10
               	movq	%r10, -0x68(%rbp)
               	movl	$0x3, %eax
               	andq	$0xff, %rcx
               	imulq	%rax, %rcx
               	andq	$0xff, %rdx
               	imulq	%rax, %rdx
               	andq	$0xff, %rsi
               	imulq	%rax, %rsi
               	andq	$0xff, %rdi
               	imulq	%rax, %rdi
               	andq	$0xff, %r8
               	imulq	%rax, %r8
               	andq	$0xff, %r9
               	imulq	%rax, %r9
               	andq	$0xff, %rbx
               	imulq	%rax, %rbx
               	andq	$0xff, %r12
               	imulq	%rax, %r12
               	andq	$0xff, %r13
               	imulq	%rax, %r13
               	andq	$0xff, %r14
               	imulq	%rax, %r14
               	andq	$0xff, %r15
               	imulq	%rax, %r15
               	movq	-0x48(%rbp), %r10
               	andq	$0xff, %r10
               	movq	%r10, -0x48(%rbp)
               	movq	-0x48(%rbp), %r10
               	imulq	%rax, %r10
               	movq	%r10, -0x48(%rbp)
               	movq	-0x50(%rbp), %r10
               	andq	$0xff, %r10
               	movq	%r10, -0x50(%rbp)
               	movq	-0x50(%rbp), %r10
               	imulq	%rax, %r10
               	movq	%r10, -0x50(%rbp)
               	movq	-0x58(%rbp), %r10
               	andq	$0xff, %r10
               	movq	%r10, -0x58(%rbp)
               	movq	-0x58(%rbp), %r10
               	imulq	%rax, %r10
               	movq	%r10, -0x58(%rbp)
               	movq	-0x60(%rbp), %r10
               	andq	$0xff, %r10
               	movq	%r10, -0x60(%rbp)
               	movq	-0x60(%rbp), %r10
               	imulq	%rax, %r10
               	movq	%r10, -0x60(%rbp)
               	movq	-0x68(%rbp), %r10
               	andq	$0xff, %r10
               	movq	%r10, -0x68(%rbp)
               	movq	%rax, %r10
               	movq	-0x68(%rbp), %rax
               	imulq	%r10, %rax
               	leaq	0x160(%rsp), %r10
               	movq	%r10, -0x68(%rbp)
               	andq	$0xff, %rcx
               	movzbq	0x60(%rsp), %r10
               	movq	%r10, -0x70(%rbp)
               	subq	-0x70(%rbp), %rcx
               	movb	%cl, 0x160(%rsp)
               	movq	%rdx, %rcx
               	andq	$0xff, %rcx
               	movzbq	0x61(%rsp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, 0x161(%rsp)
               	movq	%rsi, %rcx
               	andq	$0xff, %rcx
               	movzbq	0x62(%rsp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, 0x162(%rsp)
               	movq	%rdi, %rcx
               	andq	$0xff, %rcx
               	movzbq	0x63(%rsp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, 0x163(%rsp)
               	movq	%r8, %rcx
               	andq	$0xff, %rcx
               	movzbq	0x64(%rsp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, 0x164(%rsp)
               	movq	%r9, %rcx
               	andq	$0xff, %rcx
               	movzbq	0x65(%rsp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, 0x165(%rsp)
               	movq	%rbx, %rcx
               	andq	$0xff, %rcx
               	movzbq	0x66(%rsp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, 0x166(%rsp)
               	movq	%r12, %rcx
               	andq	$0xff, %rcx
               	movzbq	0x67(%rsp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, 0x167(%rsp)
               	movq	%r13, %rcx
               	andq	$0xff, %rcx
               	movzbq	0x68(%rsp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, 0x168(%rsp)
               	movq	%r14, %rcx
               	andq	$0xff, %rcx
               	movzbq	0x69(%rsp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, 0x169(%rsp)
               	movq	%r15, %rcx
               	andq	$0xff, %rcx
               	movzbq	0x6a(%rsp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, 0x16a(%rsp)
               	movq	-0x48(%rbp), %rcx
               	andq	$0xff, %rcx
               	movzbq	0x6b(%rsp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, 0x16b(%rsp)
               	movq	-0x50(%rbp), %rcx
               	andq	$0xff, %rcx
               	movzbq	0x6c(%rsp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, 0x16c(%rsp)
               	movq	-0x58(%rbp), %rcx
               	andq	$0xff, %rcx
               	movzbq	0x6d(%rsp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, 0x16d(%rsp)
               	movq	-0x60(%rbp), %rcx
               	andq	$0xff, %rcx
               	movzbq	0x6e(%rsp), %rdx
               	subq	%rdx, %rcx
               	movb	%cl, 0x16e(%rsp)
               	andq	$0xff, %rax
               	movzbq	0x6f(%rsp), %rcx
               	subq	%rcx, %rax
               	movb	%al, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rax
               	movq	-0x68(%rbp), %r10
               	movups	(%r10), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x60(%rsp), %rdi
               	leaq	0x70(%rsp), %r8
               	xorl	%eax, %eax
               	leaq	-0x10(%rbp), %rdx
               	movzbq	(%rdi,%rax), %rcx
               	movzbq	(%r8,%rax), %rsi
               	addq	%rcx, %rsi
               	andq	$0xff, %rsi
               	leaq	(%rsi,%rsi,2), %rsi
               	andq	$0xff, %rsi
               	subq	%rcx, %rsi
               	movq	%rsi, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
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
               	negq	%rdx
               	negq	%rsi
               	negq	%rdi
               	movl	0x110(%rsp), %r9d
               	addq	%r9, %rcx
               	movl	0x114(%rsp), %r9d
               	addq	%r9, %rdx
               	movl	0x118(%rsp), %r9d
               	addq	%r9, %rsi
               	movl	0x11c(%rsp), %r9d
               	addq	%r9, %rdi
               	movl	%ecx, 0x160(%rsp)
               	movl	%edx, 0x164(%rsp)
               	movl	%esi, 0x168(%rsp)
               	movl	%edi, 0x16c(%rsp)
               	leaq	0x110(%rsp), %r9
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
               	negq	%rdx
               	addq	%r9, %rcx
               	movl	(%rcx), %ecx
               	addq	%rdx, %rcx
               	movl	%ecx, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
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
               	leaq	0x60(%rsp), %rax
               	leaq	0x160(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	leaq	0x40(%rsp), %rax
               	movzbq	0x160(%rsp), %rcx
               	shlq	%rcx
               	movb	%cl, 0x40(%rsp)
               	movzbq	0x161(%rsp), %rcx
               	shlq	%rcx
               	movb	%cl, 0x41(%rsp)
               	movzbq	0x162(%rsp), %rcx
               	shlq	%rcx
               	movb	%cl, 0x42(%rsp)
               	movzbq	0x163(%rsp), %rcx
               	shlq	%rcx
               	movb	%cl, 0x43(%rsp)
               	movzbq	0x164(%rsp), %rcx
               	shlq	%rcx
               	movb	%cl, 0x44(%rsp)
               	movzbq	0x165(%rsp), %rcx
               	shlq	%rcx
               	movb	%cl, 0x45(%rsp)
               	movzbq	0x166(%rsp), %rcx
               	shlq	%rcx
               	movb	%cl, 0x46(%rsp)
               	movzbq	0x167(%rsp), %rcx
               	shlq	%rcx
               	movb	%cl, 0x47(%rsp)
               	movzbq	0x168(%rsp), %rcx
               	movq	%rcx, %rdx
               	shlq	%rdx
               	leaq	0x8(%rax), %rcx
               	movb	%dl, (%rcx)
               	movzbq	0x169(%rsp), %rax
               	shlq	%rax
               	movb	%al, 0x49(%rsp)
               	movzbq	0x16a(%rsp), %rax
               	shlq	%rax
               	movb	%al, 0x4a(%rsp)
               	movzbq	0x16b(%rsp), %rax
               	shlq	%rax
               	movb	%al, 0x4b(%rsp)
               	movzbq	0x16c(%rsp), %rax
               	shlq	%rax
               	movb	%al, 0x4c(%rsp)
               	movzbq	0x16d(%rsp), %rax
               	shlq	%rax
               	movb	%al, 0x4d(%rsp)
               	movzbq	0x16e(%rsp), %rax
               	shlq	%rax
               	movb	%al, 0x4e(%rsp)
               	movzbq	0x16f(%rsp), %rax
               	shlq	%rax
               	movb	%al, 0x4f(%rsp)
               	movsbq	0x160(%rsp), %rax
               	movq	%rax, %rdx
               	sarq	$0x7, %rdx
               	movsbq	0x161(%rsp), %rax
               	movq	%rax, %rsi
               	sarq	$0x7, %rsi
               	movsbq	0x162(%rsp), %rax
               	movq	%rax, %rdi
               	sarq	$0x7, %rdi
               	movsbq	0x163(%rsp), %rax
               	movq	%rax, %r8
               	sarq	$0x7, %r8
               	movsbq	0x164(%rsp), %rax
               	movq	%rax, %r9
               	sarq	$0x7, %r9
               	movsbq	0x165(%rsp), %rax
               	movq	%rax, %rbx
               	sarq	$0x7, %rbx
               	movsbq	0x166(%rsp), %rax
               	movq	%rax, %r12
               	sarq	$0x7, %r12
               	movsbq	0x167(%rsp), %rax
               	movq	%rax, %r13
               	sarq	$0x7, %r13
               	movsbq	0x168(%rsp), %rax
               	movq	%rax, %r14
               	sarq	$0x7, %r14
               	movsbq	0x169(%rsp), %rax
               	movq	%rax, %r15
               	sarq	$0x7, %r15
               	movsbq	0x16a(%rsp), %rax
               	movq	%rax, %r10
               	sarq	$0x7, %r10
               	movq	%r10, -0x48(%rbp)
               	movsbq	0x16b(%rsp), %rax
               	movq	%rax, %r10
               	sarq	$0x7, %r10
               	movq	%r10, -0x50(%rbp)
               	movsbq	0x16c(%rsp), %rax
               	movq	%rax, %r10
               	sarq	$0x7, %r10
               	movq	%r10, -0x58(%rbp)
               	movsbq	0x16d(%rsp), %rax
               	movq	%rax, %r10
               	sarq	$0x7, %r10
               	movq	%r10, -0x60(%rbp)
               	movsbq	0x16e(%rsp), %rax
               	movq	%rax, %r10
               	sarq	$0x7, %r10
               	movq	%r10, -0x68(%rbp)
               	movsbq	0x16f(%rsp), %rax
               	movq	%rax, %r10
               	sarq	$0x7, %r10
               	movq	%r10, -0x70(%rbp)
               	movl	$0x1b, %eax
               	leaq	0x160(%rsp), %r10
               	movq	%r10, -0x78(%rbp)
               	andq	%rax, %rdx
               	movb	%dl, 0x160(%rsp)
               	movq	%rsi, %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x161(%rsp)
               	movq	%rdi, %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x162(%rsp)
               	movq	%r8, %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x163(%rsp)
               	movq	%r9, %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x164(%rsp)
               	movq	%rbx, %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x165(%rsp)
               	movq	%r12, %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x166(%rsp)
               	movq	%r13, %rdx
               	andq	%rax, %rdx
               	movb	%dl, 0x167(%rsp)
               	movq	%r14, %rsi
               	andq	%rax, %rsi
               	movq	-0x78(%rbp), %rdx
               	addq	$0x8, %rdx
               	movb	%sil, (%rdx)
               	movq	%r15, %rsi
               	andq	%rax, %rsi
               	movb	%sil, 0x169(%rsp)
               	movq	-0x48(%rbp), %rsi
               	andq	%rax, %rsi
               	movb	%sil, 0x16a(%rsp)
               	movq	-0x50(%rbp), %rsi
               	andq	%rax, %rsi
               	movb	%sil, 0x16b(%rsp)
               	movq	-0x58(%rbp), %rsi
               	andq	%rax, %rsi
               	movb	%sil, 0x16c(%rsp)
               	movq	-0x60(%rbp), %rsi
               	andq	%rax, %rsi
               	movb	%sil, 0x16d(%rsp)
               	movq	-0x68(%rbp), %rsi
               	andq	%rax, %rsi
               	movb	%sil, 0x16e(%rsp)
               	movq	%rax, %r10
               	movq	-0x70(%rbp), %rax
               	andq	%r10, %rax
               	movb	%al, 0x16f(%rsp)
               	movq	0x40(%rsp), %rax
               	movq	0x160(%rsp), %rsi
               	xorq	%rsi, %rax
               	movq	(%rcx), %rcx
               	movq	(%rdx), %rdx
               	xorq	%rdx, %rcx
               	movq	%rax, 0x160(%rsp)
               	movq	%rcx, 0x168(%rsp)
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
               	leaq	0x80(%rsp), %r8
               	leaq	0x160(%rsp), %rax
               	movzbq	0x60(%rsp), %rdx
               	movzbq	0x80(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x160(%rsp)
               	movzbq	0x61(%rsp), %rdx
               	movzbq	0x81(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x161(%rsp)
               	movzbq	0x62(%rsp), %rdx
               	movzbq	0x82(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x162(%rsp)
               	movzbq	0x63(%rsp), %rdx
               	movzbq	0x83(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x163(%rsp)
               	movzbq	0x64(%rsp), %rdx
               	movzbq	0x84(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x164(%rsp)
               	movzbq	0x65(%rsp), %rdx
               	movzbq	0x85(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x165(%rsp)
               	movzbq	0x66(%rsp), %rdx
               	movzbq	0x86(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x166(%rsp)
               	movzbq	0x67(%rsp), %rdx
               	movzbq	0x87(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x167(%rsp)
               	movzbq	0x68(%rsp), %rdx
               	movzbq	0x88(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x168(%rsp)
               	movzbq	0x69(%rsp), %rdx
               	movzbq	0x89(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x169(%rsp)
               	movzbq	0x6a(%rsp), %rdx
               	movzbq	0x8a(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x16a(%rsp)
               	movzbq	0x6b(%rsp), %rdx
               	movzbq	0x8b(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x16b(%rsp)
               	movzbq	0x6c(%rsp), %rdx
               	movzbq	0x8c(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x16c(%rsp)
               	movzbq	0x6d(%rsp), %rdx
               	movzbq	0x8d(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x16d(%rsp)
               	movzbq	0x6e(%rsp), %rdx
               	movzbq	0x8e(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x16e(%rsp)
               	movzbq	0x6f(%rsp), %rdx
               	movzbq	0x8f(%rsp), %rsi
               	addq	%rsi, %rdx
               	movb	%dl, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
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
               	leaq	(%rsp), %rsi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	leaq	0x20(%rsp), %rdi
               	leaq	<rip>, %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	leaq	0x160(%rsp), %rax
               	movb	$0x42, 0x160(%rsp)
               	xorl	%ecx, %ecx
               	movb	%cl, 0x161(%rsp)
               	movb	$0x28, 0x162(%rsp)
               	movb	%cl, 0x163(%rsp)
               	movb	$0x1d, 0x164(%rsp)
               	movb	%cl, 0x165(%rsp)
               	movb	$0x16, 0x166(%rsp)
               	movb	%cl, 0x167(%rsp)
               	movb	$0x1, 0x168(%rsp)
               	movb	$0x2, 0x169(%rsp)
               	movb	$0x3, 0x16a(%rsp)
               	movb	$0x4, 0x16b(%rsp)
               	movb	$0x5, 0x16c(%rsp)
               	movb	$0x6, 0x16d(%rsp)
               	movb	$0x7, 0x16e(%rsp)
               	movb	$0x8, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	leaq	-0x10(%rbp), %r8
               	movzbq	(%rsi,%rcx), %rax
               	movzbq	(%rdi,%rcx), %r9
               	cqto
               	idivq	%r9
               	andq	$0xff, %rax
               	movb	%al, (%r8,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
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
               	leaq	(%rsp), %r8
               	leaq	0x20(%rsp), %r9
               	leaq	0x160(%rsp), %rcx
               	movsbq	(%rsp), %rax
               	movsbq	0x20(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x160(%rsp)
               	movsbq	0x1(%rsp), %rax
               	movsbq	0x21(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x161(%rsp)
               	movsbq	0x2(%rsp), %rax
               	movsbq	0x22(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x162(%rsp)
               	movsbq	0x3(%rsp), %rax
               	movsbq	0x23(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x163(%rsp)
               	movsbq	0x4(%rsp), %rax
               	movsbq	0x24(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x164(%rsp)
               	movsbq	0x5(%rsp), %rax
               	movsbq	0x25(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x165(%rsp)
               	movsbq	0x6(%rsp), %rax
               	movsbq	0x26(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x166(%rsp)
               	movsbq	0x7(%rsp), %rax
               	movsbq	0x27(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x167(%rsp)
               	movsbq	0x8(%rsp), %rax
               	movsbq	0x28(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x168(%rsp)
               	movsbq	0x9(%rsp), %rax
               	movsbq	0x29(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x169(%rsp)
               	movsbq	0xa(%rsp), %rax
               	movsbq	0x2a(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x16a(%rsp)
               	movsbq	0xb(%rsp), %rax
               	movsbq	0x2b(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x16b(%rsp)
               	movsbq	0xc(%rsp), %rax
               	movsbq	0x2c(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x16c(%rsp)
               	movsbq	0xd(%rsp), %rax
               	movsbq	0x2d(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x16d(%rsp)
               	movsbq	0xe(%rsp), %rax
               	movsbq	0x2e(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x16e(%rsp)
               	movsbq	0xf(%rsp), %rax
               	movsbq	0x2f(%rsp), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, 0x16f(%rsp)
               	leaq	0x40(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	xorl	%ecx, %ecx
               	movsbq	(%r8,%rcx), %rax
               	movsbq	(%r9,%rcx), %rdi
               	cqto
               	idivq	%rdi
               	movb	%al, (%rsi,%rcx)
               	incq	%rcx
               	cmpl	$0x10, %ecx
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
               	xorl	%eax, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x68, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x67, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x5f, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x5e, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x5d, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x5c, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x5b, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x5a, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x59, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x58, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x57, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x56, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x55, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x54, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x53, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x52, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x51, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x50, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x4f, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x4e, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x4d, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x4c, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x4b, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x4a, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x49, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x60, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x48, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x66, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x65, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x64, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x63, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x62, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x61, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x47, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x46, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x45, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x44, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x43, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x42, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x41, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x40, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3f, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3e, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3d, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3c, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3b, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3a, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x39, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x38, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x37, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x36, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x35, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x34, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x33, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x32, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x31, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x30, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x2f, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x2e, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x2d, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x2c, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x2b, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x2a, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x29, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x28, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x27, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x26, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x25, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x24, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x23, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x22, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x21, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x20, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1f, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1e, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1d, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1c, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1b, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1a, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x19, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x18, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x17, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x16, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x15, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x14, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x13, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x12, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x11, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x10, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0xf, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0xe, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0xd, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0xc, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0xb, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0xa, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x9, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x8, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x7, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x6, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x5, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x4, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x3, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x2, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
