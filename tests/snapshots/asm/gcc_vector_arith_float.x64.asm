
gcc_vector_arith_float.x64:	file format elf64-x86-64

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
               	subq	$0x20, %rsp
               	subq	$0xc0, %rsp
               	andq	$-0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x70(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x80(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	0x90(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movss	0x60(%rsp), %xmm0
               	movss	0x70(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x64(%rsp), %xmm1
               	movss	0x74(%rsp), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x68(%rsp), %xmm2
               	movss	0x78(%rsp), %xmm3
               	addss	%xmm3, %xmm2
               	movss	0x6c(%rsp), %xmm3
               	movss	0x7c(%rsp), %xmm4
               	addss	%xmm4, %xmm3
               	leaq	0xa0(%rsp), %rcx
               	movss	%xmm0, 0xa0(%rsp)
               	movss	%xmm1, 0xa4(%rsp)
               	movss	%xmm2, 0xa8(%rsp)
               	movss	%xmm3, 0xac(%rsp)
               	leaq	-0x10(%rbp), %rdx
               	movss	0x60(%rsp), %xmm0
               	movss	0x70(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movss	0x64(%rsp), %xmm0
               	movss	0x74(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0xc(%rbp)
               	movss	0x68(%rsp), %xmm0
               	movss	0x78(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movss	0x6c(%rsp), %xmm0
               	movss	0x7c(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x4(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movss	0x60(%rsp), %xmm0
               	movss	0x70(%rsp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	0x64(%rsp), %xmm1
               	movss	0x74(%rsp), %xmm2
               	subss	%xmm2, %xmm1
               	movss	0x68(%rsp), %xmm2
               	movss	0x78(%rsp), %xmm3
               	subss	%xmm3, %xmm2
               	movss	0x6c(%rsp), %xmm3
               	movss	0x7c(%rsp), %xmm4
               	subss	%xmm4, %xmm3
               	leaq	0xa0(%rsp), %rcx
               	movss	%xmm0, 0xa0(%rsp)
               	movss	%xmm1, 0xa4(%rsp)
               	movss	%xmm2, 0xa8(%rsp)
               	movss	%xmm3, 0xac(%rsp)
               	leaq	-0x10(%rbp), %rdx
               	movss	0x60(%rsp), %xmm0
               	movss	0x70(%rsp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movss	0x64(%rsp), %xmm0
               	movss	0x74(%rsp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, -0xc(%rbp)
               	movss	0x68(%rsp), %xmm0
               	movss	0x78(%rsp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movss	0x6c(%rsp), %xmm0
               	movss	0x7c(%rsp), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, -0x4(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movss	0x60(%rsp), %xmm0
               	movss	0x70(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	0x64(%rsp), %xmm1
               	movss	0x74(%rsp), %xmm2
               	mulss	%xmm2, %xmm1
               	movss	0x68(%rsp), %xmm2
               	movss	0x78(%rsp), %xmm3
               	mulss	%xmm3, %xmm2
               	movss	0x6c(%rsp), %xmm3
               	movss	0x7c(%rsp), %xmm4
               	mulss	%xmm4, %xmm3
               	leaq	0xa0(%rsp), %rcx
               	movss	%xmm0, 0xa0(%rsp)
               	movss	%xmm1, 0xa4(%rsp)
               	movss	%xmm2, 0xa8(%rsp)
               	movss	%xmm3, 0xac(%rsp)
               	leaq	-0x10(%rbp), %rdx
               	movss	0x60(%rsp), %xmm0
               	movss	0x70(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movss	0x64(%rsp), %xmm0
               	movss	0x74(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, -0xc(%rbp)
               	movss	0x68(%rsp), %xmm0
               	movss	0x78(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movss	0x6c(%rsp), %xmm0
               	movss	0x7c(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, -0x4(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movss	0x60(%rsp), %xmm0
               	movss	0x70(%rsp), %xmm1
               	divss	%xmm1, %xmm0
               	movss	0x64(%rsp), %xmm1
               	movss	0x74(%rsp), %xmm2
               	divss	%xmm2, %xmm1
               	movss	0x68(%rsp), %xmm2
               	movss	0x78(%rsp), %xmm3
               	divss	%xmm3, %xmm2
               	movss	0x6c(%rsp), %xmm3
               	movss	0x7c(%rsp), %xmm4
               	divss	%xmm4, %xmm3
               	leaq	0xa0(%rsp), %rcx
               	movss	%xmm0, 0xa0(%rsp)
               	movss	%xmm1, 0xa4(%rsp)
               	movss	%xmm2, 0xa8(%rsp)
               	movss	%xmm3, 0xac(%rsp)
               	leaq	-0x10(%rbp), %rdx
               	movss	0x60(%rsp), %xmm0
               	movss	0x70(%rsp), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movss	0x64(%rsp), %xmm0
               	movss	0x74(%rsp), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, -0xc(%rbp)
               	movss	0x68(%rsp), %xmm0
               	movss	0x78(%rsp), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movss	0x6c(%rsp), %xmm0
               	movss	0x7c(%rsp), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, -0x4(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movsd	0x80(%rsp), %xmm0
               	movsd	0x90(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	0x88(%rsp), %xmm1
               	movsd	0x98(%rsp), %xmm2
               	addsd	%xmm2, %xmm1
               	leaq	0xa0(%rsp), %rcx
               	movsd	%xmm0, 0xa0(%rsp)
               	movsd	%xmm1, 0xa8(%rsp)
               	leaq	-0x10(%rbp), %rdx
               	movsd	0x80(%rsp), %xmm0
               	movsd	0x90(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	0x88(%rsp), %xmm0
               	movsd	0x98(%rsp), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movsd	0x80(%rsp), %xmm0
               	movsd	0x90(%rsp), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	0x88(%rsp), %xmm1
               	movsd	0x98(%rsp), %xmm2
               	subsd	%xmm2, %xmm1
               	leaq	0xa0(%rsp), %rcx
               	movsd	%xmm0, 0xa0(%rsp)
               	movsd	%xmm1, 0xa8(%rsp)
               	leaq	-0x10(%rbp), %rdx
               	movsd	0x80(%rsp), %xmm0
               	movsd	0x90(%rsp), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	0x88(%rsp), %xmm0
               	movsd	0x98(%rsp), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movsd	0x80(%rsp), %xmm0
               	movsd	0x90(%rsp), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	0x88(%rsp), %xmm1
               	movsd	0x98(%rsp), %xmm2
               	mulsd	%xmm2, %xmm1
               	leaq	0xa0(%rsp), %rcx
               	movsd	%xmm0, 0xa0(%rsp)
               	movsd	%xmm1, 0xa8(%rsp)
               	leaq	-0x10(%rbp), %rdx
               	movsd	0x80(%rsp), %xmm0
               	movsd	0x90(%rsp), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	0x88(%rsp), %xmm0
               	movsd	0x98(%rsp), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movsd	0x80(%rsp), %xmm0
               	movsd	0x90(%rsp), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	0x88(%rsp), %xmm1
               	movsd	0x98(%rsp), %xmm2
               	divsd	%xmm2, %xmm1
               	leaq	0xa0(%rsp), %rcx
               	movsd	%xmm0, 0xa0(%rsp)
               	movsd	%xmm1, 0xa8(%rsp)
               	leaq	-0x10(%rbp), %rdx
               	movsd	0x80(%rsp), %xmm0
               	movsd	0x90(%rsp), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	0x88(%rsp), %xmm0
               	movsd	0x98(%rsp), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xa0(%rsp), %rax
               	movss	(%rsp), %xmm0
               	movss	0x20(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xa0(%rsp)
               	movss	0x4(%rsp), %xmm0
               	movss	0x24(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xa4(%rsp)
               	movss	0x8(%rsp), %xmm0
               	movss	0x28(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xa8(%rsp)
               	movss	0xc(%rsp), %xmm0
               	movss	0x2c(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xac(%rsp)
               	movss	0x10(%rsp), %xmm0
               	movss	0x30(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xb0(%rsp)
               	movss	0x14(%rsp), %xmm0
               	movss	0x34(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xb4(%rsp)
               	movss	0x18(%rsp), %xmm0
               	movss	0x38(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xb8(%rsp)
               	movss	0x1c(%rsp), %xmm0
               	movss	0x3c(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xbc(%rsp)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movss	(%rsp), %xmm0
               	movss	0x20(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x20(%rbp)
               	movss	0x4(%rsp), %xmm0
               	movss	0x24(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x1c(%rbp)
               	movss	0x8(%rsp), %xmm0
               	movss	0x28(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x18(%rbp)
               	movss	0xc(%rsp), %xmm0
               	movss	0x2c(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x14(%rbp)
               	movss	0x10(%rsp), %xmm0
               	movss	0x30(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movss	0x14(%rsp), %xmm0
               	movss	0x34(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0xc(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movss	0x18(%rsp), %xmm0
               	movss	0x38(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movss	0x1c(%rsp), %xmm0
               	movss	0x3c(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, -0x4(%rbp)
               	leaq	0x40(%rsp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	0xa0(%rsp), %rax
               	movss	(%rsp), %xmm0
               	movss	0x20(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xa0(%rsp)
               	movss	0x4(%rsp), %xmm0
               	movss	0x24(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xa4(%rsp)
               	movss	0x8(%rsp), %xmm0
               	movss	0x28(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xa8(%rsp)
               	movss	0xc(%rsp), %xmm0
               	movss	0x2c(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xac(%rsp)
               	movss	0x10(%rsp), %xmm0
               	movss	0x30(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xb0(%rsp)
               	movss	0x14(%rsp), %xmm0
               	movss	0x34(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xb4(%rsp)
               	movss	0x18(%rsp), %xmm0
               	movss	0x38(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xb8(%rsp)
               	movss	0x1c(%rsp), %xmm0
               	movss	0x3c(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xbc(%rsp)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movss	(%rsp), %xmm0
               	movss	0x20(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, -0x20(%rbp)
               	movss	0x4(%rsp), %xmm0
               	movss	0x24(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, -0x1c(%rbp)
               	movss	0x8(%rsp), %xmm0
               	movss	0x28(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, -0x18(%rbp)
               	movss	0xc(%rsp), %xmm0
               	movss	0x2c(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, -0x14(%rbp)
               	movss	0x10(%rsp), %xmm0
               	movss	0x30(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movss	0x14(%rsp), %xmm0
               	movss	0x34(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, -0xc(%rbp)
               	leaq	-0x20(%rbp), %rcx
               	movss	0x18(%rsp), %xmm0
               	movss	0x38(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movss	0x1c(%rsp), %xmm0
               	movss	0x3c(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, -0x4(%rbp)
               	leaq	0x40(%rsp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movss	0x60(%rsp), %xmm0
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	0x64(%rsp), %xmm1
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	movss	0x68(%rsp), %xmm2
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm2
               	movss	0x6c(%rsp), %xmm3
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm3
               	movss	%xmm0, 0xa0(%rsp)
               	movss	%xmm1, 0xa4(%rsp)
               	movss	%xmm2, 0xa8(%rsp)
               	movss	%xmm3, 0xac(%rsp)
               	movss	0x60(%rsp), %xmm0
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movss	0x64(%rsp), %xmm0
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, -0xc(%rbp)
               	movss	0x68(%rsp), %xmm0
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	leaq	-0x10(%rbp), %rcx
               	movss	0x6c(%rsp), %xmm0
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, -0x4(%rbp)
               	leaq	0xa0(%rsp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x3, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rax, %xmm0
               	movss	0x60(%rsp), %xmm1
               	mulss	%xmm0, %xmm1
               	movss	0x64(%rsp), %xmm2
               	mulss	%xmm0, %xmm2
               	movss	0x68(%rsp), %xmm3
               	mulss	%xmm0, %xmm3
               	movss	0x6c(%rsp), %xmm4
               	vmulss	%xmm0, %xmm4, %xmm0
               	movss	%xmm1, 0xa0(%rsp)
               	movss	%xmm2, 0xa4(%rsp)
               	movss	%xmm3, 0xa8(%rsp)
               	movss	%xmm0, 0xac(%rsp)
               	movss	0x60(%rsp), %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movss	0x64(%rsp), %xmm0
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, -0xc(%rbp)
               	movss	0x68(%rsp), %xmm0
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movss	0x6c(%rsp), %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, -0x4(%rbp)
               	leaq	0xa0(%rsp), %rcx
               	leaq	-0x10(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movabsq	$0x4010000000000000, %rax # imm = 0x4010000000000000
               	movsd	0x80(%rsp), %xmm0
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	0x88(%rsp), %xmm1
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm1
               	leaq	0xa0(%rsp), %rcx
               	movsd	%xmm0, 0xa0(%rsp)
               	movsd	%xmm1, 0xa8(%rsp)
               	leaq	-0x10(%rbp), %rdx
               	movsd	0x80(%rsp), %xmm0
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	0x88(%rsp), %xmm0
               	movq	%rax, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movl	$0x3, %eax
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rax, %xmm0
               	movsd	0x80(%rsp), %xmm1
               	addsd	%xmm0, %xmm1
               	movsd	0x88(%rsp), %xmm2
               	vaddsd	%xmm0, %xmm2, %xmm0
               	leaq	0xa0(%rsp), %rcx
               	movsd	%xmm1, 0xa0(%rsp)
               	movsd	%xmm0, 0xa8(%rsp)
               	leaq	-0x10(%rbp), %rdx
               	movsd	0x80(%rsp), %xmm0
               	movabsq	$0x4008000000000000, %rax # imm = 0x4008000000000000
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	0x88(%rsp), %xmm0
               	movq	%rax, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	movss	0x60(%rsp), %xmm0
               	movss	0x70(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	0x64(%rsp), %xmm1
               	movss	0x74(%rsp), %xmm2
               	mulss	%xmm2, %xmm1
               	movss	0x68(%rsp), %xmm2
               	movss	0x78(%rsp), %xmm3
               	mulss	%xmm3, %xmm2
               	movss	0x6c(%rsp), %xmm3
               	movss	0x7c(%rsp), %xmm4
               	mulss	%xmm4, %xmm3
               	leaq	0x40(%rsp), %rdx
               	movss	%xmm0, 0x40(%rsp)
               	movss	%xmm1, 0x44(%rsp)
               	movss	%xmm2, 0x48(%rsp)
               	movss	%xmm3, 0x4c(%rsp)
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0xa0(%rsp), %xmm0
               	movss	0x70(%rsp), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	0xa4(%rsp), %xmm1
               	movss	0x74(%rsp), %xmm2
               	mulss	%xmm2, %xmm1
               	movss	0xa8(%rsp), %xmm2
               	movss	0x78(%rsp), %xmm3
               	mulss	%xmm3, %xmm2
               	movss	0xac(%rsp), %xmm3
               	movss	0x7c(%rsp), %xmm4
               	mulss	%xmm4, %xmm3
               	movss	%xmm0, 0xa0(%rsp)
               	movss	%xmm1, 0xa4(%rsp)
               	movss	%xmm2, 0xa8(%rsp)
               	movss	%xmm3, 0xac(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rax
               	movss	0x60(%rsp), %xmm0
               	movss	0x70(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x64(%rsp), %xmm1
               	movss	0x74(%rsp), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x68(%rsp), %xmm2
               	movss	0x78(%rsp), %xmm3
               	addss	%xmm3, %xmm2
               	movss	0x6c(%rsp), %xmm3
               	movss	0x7c(%rsp), %xmm4
               	addss	%xmm4, %xmm3
               	leaq	0x40(%rsp), %rdx
               	movss	%xmm0, 0x40(%rsp)
               	movss	%xmm1, 0x44(%rsp)
               	movss	%xmm2, 0x48(%rsp)
               	movss	%xmm3, 0x4c(%rsp)
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movss	0xa0(%rsp), %xmm0
               	movss	0x70(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0xa4(%rsp), %xmm1
               	movss	0x74(%rsp), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0xa8(%rsp), %xmm2
               	movss	0x78(%rsp), %xmm3
               	addss	%xmm3, %xmm2
               	movss	0xac(%rsp), %xmm3
               	movss	0x7c(%rsp), %xmm4
               	addss	%xmm4, %xmm3
               	movss	%xmm0, 0xa0(%rsp)
               	movss	%xmm1, 0xa4(%rsp)
               	movss	%xmm2, 0xa8(%rsp)
               	movss	%xmm3, 0xac(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rax
               	movsd	0x80(%rsp), %xmm0
               	movsd	0x90(%rsp), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	0x88(%rsp), %xmm1
               	movsd	0x98(%rsp), %xmm2
               	divsd	%xmm2, %xmm1
               	leaq	0x40(%rsp), %rdx
               	movsd	%xmm0, 0x40(%rsp)
               	movsd	%xmm1, 0x48(%rsp)
               	leaq	0xa0(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movsd	0xa0(%rsp), %xmm0
               	movsd	0x90(%rsp), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	0xa8(%rsp), %xmm1
               	movsd	0x98(%rsp), %xmm2
               	divsd	%xmm2, %xmm1
               	movsd	%xmm0, 0xa0(%rsp)
               	movsd	%xmm1, 0xa8(%rsp)
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
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movss	0x40(%rsp), %xmm0
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	0x44(%rsp), %xmm1
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	movss	0x48(%rsp), %xmm2
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm2
               	movss	0x4c(%rsp), %xmm3
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm3
               	movss	%xmm0, 0x40(%rsp)
               	movss	%xmm1, 0x44(%rsp)
               	movss	%xmm2, 0x48(%rsp)
               	movss	%xmm3, 0x4c(%rsp)
               	movss	0x60(%rsp), %xmm0
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	0x64(%rsp), %xmm1
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	movss	0x68(%rsp), %xmm2
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm2
               	movss	0x6c(%rsp), %xmm3
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm3
               	leaq	0xa0(%rsp), %rdx
               	movss	%xmm0, 0xa0(%rsp)
               	movss	%xmm1, 0xa4(%rsp)
               	movss	%xmm2, 0xa8(%rsp)
               	movss	%xmm3, 0xac(%rsp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movss	0x60(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x64(%rsp), %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movss	0x68(%rsp), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	movss	0x6c(%rsp), %xmm3
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm3
               	leaq	0xa0(%rsp), %rcx
               	movss	%xmm0, 0xa0(%rsp)
               	movss	%xmm1, 0xa4(%rsp)
               	movss	%xmm2, 0xa8(%rsp)
               	movss	%xmm3, 0xac(%rsp)
               	leaq	-0x10(%rbp), %rdx
               	movss	0x60(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, -0x10(%rbp)
               	movss	0x64(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, -0xc(%rbp)
               	movss	0x68(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, -0x8(%rbp)
               	movss	0x6c(%rsp), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, -0x4(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movzbq	0xaf(%rsp), %rax
               	xorq	$0x80, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movsd	0x80(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0x88(%rsp), %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	leaq	0xa0(%rsp), %rcx
               	movsd	%xmm0, 0xa0(%rsp)
               	movsd	%xmm1, 0xa8(%rsp)
               	leaq	-0x10(%rbp), %rdx
               	movsd	0x80(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	%xmm0, -0x10(%rbp)
               	movsd	0x88(%rsp), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	%xmm0, -0x8(%rbp)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %r8
               	leaq	0x70(%rsp), %r9
               	movss	0x60(%rsp), %xmm0
               	movss	0x70(%rsp), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x64(%rsp), %xmm1
               	movss	0x74(%rsp), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x68(%rsp), %xmm2
               	movss	0x78(%rsp), %xmm3
               	addss	%xmm3, %xmm2
               	movss	0x6c(%rsp), %xmm3
               	movss	0x7c(%rsp), %xmm4
               	addss	%xmm4, %xmm3
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movss	0x60(%rsp), %xmm4
               	movq	%rax, %xmm15
               	vfmsub132ss	%xmm15, %xmm4, %xmm0 # xmm0 = (xmm0 * xmm15) - xmm4
               	movss	0x64(%rsp), %xmm4
               	movq	%rax, %xmm15
               	vfmsub132ss	%xmm15, %xmm4, %xmm1 # xmm1 = (xmm1 * xmm15) - xmm4
               	movss	0x68(%rsp), %xmm4
               	movq	%rax, %xmm15
               	vfmsub132ss	%xmm15, %xmm4, %xmm2 # xmm2 = (xmm2 * xmm15) - xmm4
               	movss	0x6c(%rsp), %xmm4
               	movq	%rax, %xmm15
               	vfmsub132ss	%xmm15, %xmm4, %xmm3 # xmm3 = (xmm3 * xmm15) - xmm4
               	movss	%xmm0, 0xa0(%rsp)
               	movss	%xmm1, 0xa4(%rsp)
               	movss	%xmm2, 0xa8(%rsp)
               	movss	%xmm3, 0xac(%rsp)
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	leaq	(%rdx,%rcx), %rsi
               	leaq	(%r8,%rcx), %rdi
               	movss	(%rdi), %xmm0
               	addq	%r9, %rcx
               	movss	(%rcx), %xmm1
               	vaddss	%xmm1, %xmm0, %xmm1
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movq	%rcx, %xmm15
               	vfmsub231ss	%xmm15, %xmm1, %xmm0 # xmm0 = (xmm1 * xmm15) - xmm0
               	movss	%xmm0, (%rsi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0xa0(%rsp), %rcx
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
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movl	$0x16, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movl	$0x15, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movl	$0x13, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movl	$0x12, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movl	$0x11, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movl	$0x10, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movl	$0xf, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movl	$0xe, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movl	$0xd, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movl	$0xc, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movl	$0xb, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movl	$0xa, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movl	$0x9, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movl	$0x8, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movl	$0x7, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movl	$0x6, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movl	$0x5, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movl	$0x4, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movl	$0x3, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movl	$0x2, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x20(%rbp), %rsp
               	leave
               	retq
