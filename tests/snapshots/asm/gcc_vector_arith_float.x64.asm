
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
               	subq	$0x8d0, %rsp            # imm = 0x8D0
               	subq	$0x240, %rsp            # imm = 0x240
               	andq	$-0x20, %rsp
               	leaq	0x80(%rsp), %rax
               	leaq	<rip>, %rcx
               	pushq	%rdx
               	movq	(%rcx), %rdx
               	movq	%rdx, (%rax)
               	movq	0x8(%rcx), %rdx
               	movq	%rdx, 0x8(%rax)
               	popq	%rdx
               	leaq	0x90(%rsp), %rsi
               	leaq	<rip>, %rcx
               	pushq	%rax
               	movq	(%rcx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rcx), %rax
               	movq	%rax, 0x8(%rsi)
               	popq	%rax
               	leaq	0xa0(%rsp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	0xb0(%rsp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	leaq	(%rsp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	movq	0x18(%rdx), %rax
               	movq	%rax, 0x18(%rcx)
               	popq	%rax
               	leaq	0x20(%rsp), %rcx
               	leaq	<rip>, %rdx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rcx)
               	movq	0x18(%rdx), %rax
               	movq	%rax, 0x18(%rcx)
               	popq	%rax
               	movss	(%rax), %xmm0
               	movss	(%rsi), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x4(%rax), %xmm1
               	movss	0x4(%rsi), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rax), %xmm2
               	movss	0x8(%rsi), %xmm3
               	addss	%xmm3, %xmm2
               	movss	0xc(%rax), %xmm3
               	movss	0xc(%rsi), %xmm4
               	addss	%xmm4, %xmm3
               	leaq	0xc0(%rsp), %rcx
               	movss	%xmm0, (%rcx)
               	movss	%xmm1, 0x4(%rcx)
               	movss	%xmm2, 0x8(%rcx)
               	movss	%xmm3, 0xc(%rcx)
               	leaq	-0xa0(%rbp), %rdx
               	movss	(%rax), %xmm0
               	movss	(%rsi), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx)
               	movss	0x4(%rax), %xmm0
               	movss	0x4(%rsi), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx)
               	movss	0x8(%rax), %xmm0
               	movss	0x8(%rsi), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx)
               	movss	0xc(%rax), %xmm0
               	movss	0xc(%rsi), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rax
               	leaq	0x90(%rsp), %rsi
               	movss	(%rax), %xmm0
               	movss	(%rsi), %xmm1
               	subss	%xmm1, %xmm0
               	movss	0x4(%rax), %xmm1
               	movss	0x4(%rsi), %xmm2
               	subss	%xmm2, %xmm1
               	movss	0x8(%rax), %xmm2
               	movss	0x8(%rsi), %xmm3
               	subss	%xmm3, %xmm2
               	movss	0xc(%rax), %xmm3
               	movss	0xc(%rsi), %xmm4
               	subss	%xmm4, %xmm3
               	leaq	0xd0(%rsp), %rcx
               	movss	%xmm0, (%rcx)
               	movss	%xmm1, 0x4(%rcx)
               	movss	%xmm2, 0x8(%rcx)
               	movss	%xmm3, 0xc(%rcx)
               	leaq	-0xd8(%rbp), %rdx
               	movss	(%rax), %xmm0
               	movss	(%rsi), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx)
               	movss	0x4(%rax), %xmm0
               	movss	0x4(%rsi), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx)
               	movss	0x8(%rax), %xmm0
               	movss	0x8(%rsi), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx)
               	movss	0xc(%rax), %xmm0
               	movss	0xc(%rsi), %xmm1
               	subss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rax
               	leaq	0x90(%rsp), %rsi
               	movss	(%rax), %xmm0
               	movss	(%rsi), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	0x4(%rax), %xmm1
               	movss	0x4(%rsi), %xmm2
               	mulss	%xmm2, %xmm1
               	movss	0x8(%rax), %xmm2
               	movss	0x8(%rsi), %xmm3
               	mulss	%xmm3, %xmm2
               	movss	0xc(%rax), %xmm3
               	movss	0xc(%rsi), %xmm4
               	mulss	%xmm4, %xmm3
               	leaq	0xe0(%rsp), %rcx
               	movss	%xmm0, (%rcx)
               	movss	%xmm1, 0x4(%rcx)
               	movss	%xmm2, 0x8(%rcx)
               	movss	%xmm3, 0xc(%rcx)
               	leaq	-0x110(%rbp), %rdx
               	movss	(%rax), %xmm0
               	movss	(%rsi), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx)
               	movss	0x4(%rax), %xmm0
               	movss	0x4(%rsi), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx)
               	movss	0x8(%rax), %xmm0
               	movss	0x8(%rsi), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx)
               	movss	0xc(%rax), %xmm0
               	movss	0xc(%rsi), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rax
               	leaq	0x90(%rsp), %rsi
               	movss	(%rax), %xmm0
               	movss	(%rsi), %xmm1
               	divss	%xmm1, %xmm0
               	movss	0x4(%rax), %xmm1
               	movss	0x4(%rsi), %xmm2
               	divss	%xmm2, %xmm1
               	movss	0x8(%rax), %xmm2
               	movss	0x8(%rsi), %xmm3
               	divss	%xmm3, %xmm2
               	movss	0xc(%rax), %xmm3
               	movss	0xc(%rsi), %xmm4
               	divss	%xmm4, %xmm3
               	leaq	0xf0(%rsp), %rcx
               	movss	%xmm0, (%rcx)
               	movss	%xmm1, 0x4(%rcx)
               	movss	%xmm2, 0x8(%rcx)
               	movss	%xmm3, 0xc(%rcx)
               	leaq	-0x148(%rbp), %rdx
               	movss	(%rax), %xmm0
               	movss	(%rsi), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx)
               	movss	0x4(%rax), %xmm0
               	movss	0x4(%rsi), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx)
               	movss	0x8(%rax), %xmm0
               	movss	0x8(%rsi), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx)
               	movss	0xc(%rax), %xmm0
               	movss	0xc(%rsi), %xmm1
               	divss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %rsi
               	movsd	(%rax), %xmm0
               	movsd	(%rsi), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	0x8(%rax), %xmm1
               	movsd	0x8(%rsi), %xmm2
               	addsd	%xmm2, %xmm1
               	leaq	0x100(%rsp), %rcx
               	movsd	%xmm0, (%rcx)
               	movsd	%xmm1, 0x8(%rcx)
               	leaq	-0x180(%rbp), %rdx
               	movsd	(%rax), %xmm0
               	movsd	(%rsi), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdx)
               	movsd	0x8(%rax), %xmm0
               	movsd	0x8(%rsi), %xmm1
               	addsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %rsi
               	movsd	(%rax), %xmm0
               	movsd	(%rsi), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	0x8(%rax), %xmm1
               	movsd	0x8(%rsi), %xmm2
               	subsd	%xmm2, %xmm1
               	leaq	0x110(%rsp), %rcx
               	movsd	%xmm0, (%rcx)
               	movsd	%xmm1, 0x8(%rcx)
               	leaq	-0x1b8(%rbp), %rdx
               	movsd	(%rax), %xmm0
               	movsd	(%rsi), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdx)
               	movsd	0x8(%rax), %xmm0
               	movsd	0x8(%rsi), %xmm1
               	subsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %rsi
               	movsd	(%rax), %xmm0
               	movsd	(%rsi), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	0x8(%rax), %xmm1
               	movsd	0x8(%rsi), %xmm2
               	mulsd	%xmm2, %xmm1
               	leaq	0x120(%rsp), %rcx
               	movsd	%xmm0, (%rcx)
               	movsd	%xmm1, 0x8(%rcx)
               	leaq	-0x1f0(%rbp), %rdx
               	movsd	(%rax), %xmm0
               	movsd	(%rsi), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdx)
               	movsd	0x8(%rax), %xmm0
               	movsd	0x8(%rsi), %xmm1
               	mulsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xa0(%rsp), %rax
               	leaq	0xb0(%rsp), %rsi
               	movsd	(%rax), %xmm0
               	movsd	(%rsi), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	0x8(%rax), %xmm1
               	movsd	0x8(%rsi), %xmm2
               	divsd	%xmm2, %xmm1
               	leaq	0x130(%rsp), %rcx
               	movsd	%xmm0, (%rcx)
               	movsd	%xmm1, 0x8(%rcx)
               	leaq	-0x228(%rbp), %rdx
               	movsd	(%rax), %xmm0
               	movsd	(%rsi), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, (%rdx)
               	movsd	0x8(%rax), %xmm0
               	movsd	0x8(%rsi), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	%xmm0, 0x8(%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	-0x588(%rbp), %rdx
               	movss	(%rax), %xmm0
               	movss	(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx)
               	movss	0x4(%rax), %xmm0
               	movss	0x4(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx)
               	movss	0x8(%rax), %xmm0
               	movss	0x8(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx)
               	movss	0xc(%rax), %xmm0
               	movss	0xc(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx)
               	movss	0x10(%rax), %xmm0
               	movss	0x10(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x10(%rdx)
               	movss	0x14(%rax), %xmm0
               	movss	0x14(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x14(%rdx)
               	movss	0x18(%rax), %xmm0
               	movss	0x18(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x18(%rdx)
               	movss	0x1c(%rax), %xmm0
               	movss	0x1c(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x1c(%rdx)
               	leaq	0x40(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rsi)
               	movq	0x18(%rdx), %rax
               	movq	%rax, 0x18(%rsi)
               	popq	%rax
               	leaq	-0x280(%rbp), %rdx
               	movss	(%rax), %xmm0
               	movss	(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx)
               	movss	0x4(%rax), %xmm0
               	movss	0x4(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx)
               	movss	0x8(%rax), %xmm0
               	movss	0x8(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx)
               	movss	0xc(%rax), %xmm0
               	movss	0xc(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx)
               	movss	0x10(%rax), %xmm0
               	movss	0x10(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x10(%rdx)
               	movss	0x14(%rax), %xmm0
               	movss	0x14(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x14(%rdx)
               	leaq	-0x280(%rbp), %rdx
               	movss	0x18(%rax), %xmm0
               	movss	0x18(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x18(%rdx)
               	movss	0x1c(%rax), %xmm0
               	movss	0x1c(%rcx), %xmm1
               	addss	%xmm1, %xmm0
               	movss	%xmm0, 0x1c(%rdx)
               	leaq	0x40(%rsp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	-0x5a8(%rbp), %rdx
               	movss	(%rax), %xmm0
               	movss	(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx)
               	movss	0x4(%rax), %xmm0
               	movss	0x4(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx)
               	movss	0x8(%rax), %xmm0
               	movss	0x8(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx)
               	movss	0xc(%rax), %xmm0
               	movss	0xc(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx)
               	movss	0x10(%rax), %xmm0
               	movss	0x10(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x10(%rdx)
               	movss	0x14(%rax), %xmm0
               	movss	0x14(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x14(%rdx)
               	movss	0x18(%rax), %xmm0
               	movss	0x18(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x18(%rdx)
               	movss	0x1c(%rax), %xmm0
               	movss	0x1c(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x1c(%rdx)
               	leaq	0x60(%rsp), %rsi
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rsi)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rsi)
               	movq	0x10(%rdx), %rax
               	movq	%rax, 0x10(%rsi)
               	movq	0x18(%rdx), %rax
               	movq	%rax, 0x18(%rsi)
               	popq	%rax
               	leaq	-0x2d8(%rbp), %rdx
               	movss	(%rax), %xmm0
               	movss	(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, (%rdx)
               	movss	0x4(%rax), %xmm0
               	movss	0x4(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x4(%rdx)
               	movss	0x8(%rax), %xmm0
               	movss	0x8(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x8(%rdx)
               	movss	0xc(%rax), %xmm0
               	movss	0xc(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0xc(%rdx)
               	movss	0x10(%rax), %xmm0
               	movss	0x10(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x10(%rdx)
               	movss	0x14(%rax), %xmm0
               	movss	0x14(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x14(%rdx)
               	leaq	-0x2d8(%rbp), %rdx
               	movss	0x18(%rax), %xmm0
               	movss	0x18(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x18(%rdx)
               	movss	0x1c(%rax), %xmm0
               	movss	0x1c(%rcx), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	%xmm0, 0x1c(%rdx)
               	leaq	0x60(%rsp), %rcx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rax
               	movl	$0x40200000, %ecx       # imm = 0x40200000
               	movss	(%rax), %xmm0
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	0x4(%rax), %xmm1
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm1
               	movss	0x8(%rax), %xmm2
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm2
               	movss	0xc(%rax), %xmm3
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm3
               	leaq	0x140(%rsp), %rdx
               	movss	%xmm0, (%rdx)
               	movss	%xmm1, 0x4(%rdx)
               	movss	%xmm2, 0x8(%rdx)
               	movss	%xmm3, 0xc(%rdx)
               	leaq	-0x310(%rbp), %rdx
               	movss	(%rax), %xmm0
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, (%rdx)
               	movss	0x4(%rax), %xmm0
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rdx)
               	movss	0x8(%rax), %xmm0
               	movq	%rcx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rdx)
               	leaq	-0x310(%rbp), %rcx
               	movss	0xc(%rax), %xmm0
               	movl	$0x40200000, %eax       # imm = 0x40200000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rcx)
               	leaq	0x140(%rsp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rsi
               	movzbq	(%rcx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rax
               	movl	$0x3, %ecx
               	xorps	%xmm0, %xmm0
               	cvtsi2ss	%rcx, %xmm0
               	movss	(%rax), %xmm1
               	mulss	%xmm0, %xmm1
               	movss	0x4(%rax), %xmm2
               	mulss	%xmm0, %xmm2
               	movss	0x8(%rax), %xmm3
               	mulss	%xmm0, %xmm3
               	movss	0xc(%rax), %xmm4
               	movapd	%xmm0, %xmm15
               	movapd	%xmm4, %xmm0
               	mulss	%xmm15, %xmm0
               	leaq	0x150(%rsp), %rcx
               	movss	%xmm1, (%rcx)
               	movss	%xmm2, 0x4(%rcx)
               	movss	%xmm3, 0x8(%rcx)
               	movss	%xmm0, 0xc(%rcx)
               	leaq	-0x340(%rbp), %rcx
               	movss	(%rax), %xmm0
               	movl	$0x40400000, %edx       # imm = 0x40400000
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, (%rcx)
               	movss	0x4(%rax), %xmm0
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rcx)
               	movss	0x8(%rax), %xmm0
               	movq	%rdx, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rcx)
               	movss	0xc(%rax), %xmm0
               	movl	$0x40400000, %eax       # imm = 0x40400000
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rcx)
               	leaq	0x150(%rsp), %rcx
               	leaq	-0x340(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xa0(%rsp), %rax
               	movabsq	$0x4010000000000000, %rsi # imm = 0x4010000000000000
               	movsd	(%rax), %xmm0
               	movq	%rsi, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	0x8(%rax), %xmm1
               	movq	%rsi, %xmm15
               	divsd	%xmm15, %xmm1
               	leaq	0x160(%rsp), %rcx
               	movsd	%xmm0, (%rcx)
               	movsd	%xmm1, 0x8(%rcx)
               	leaq	-0x370(%rbp), %rdx
               	movsd	(%rax), %xmm0
               	movq	%rsi, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, (%rdx)
               	movsd	0x8(%rax), %xmm0
               	movq	%rsi, %xmm15
               	divsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xa0(%rsp), %rax
               	movl	$0x3, %ecx
               	xorps	%xmm0, %xmm0
               	cvtsi2sd	%rcx, %xmm0
               	movsd	(%rax), %xmm1
               	addsd	%xmm0, %xmm1
               	movsd	0x8(%rax), %xmm2
               	movapd	%xmm0, %xmm15
               	movapd	%xmm2, %xmm0
               	addsd	%xmm15, %xmm0
               	leaq	0x170(%rsp), %rcx
               	movsd	%xmm1, (%rcx)
               	movsd	%xmm0, 0x8(%rcx)
               	leaq	-0x3a0(%rbp), %rdx
               	movsd	(%rax), %xmm0
               	movabsq	$0x4008000000000000, %rsi # imm = 0x4008000000000000
               	movq	%rsi, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, (%rdx)
               	movsd	0x8(%rax), %xmm0
               	movq	%rsi, %xmm15
               	addsd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rsi
               	leaq	0x90(%rsp), %rax
               	movss	(%rsi), %xmm0
               	movss	(%rax), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	0x4(%rsi), %xmm1
               	movss	0x4(%rax), %xmm2
               	mulss	%xmm2, %xmm1
               	movss	0x8(%rsi), %xmm2
               	movss	0x8(%rax), %xmm3
               	mulss	%xmm3, %xmm2
               	movss	0xc(%rsi), %xmm3
               	movss	0xc(%rax), %xmm4
               	mulss	%xmm4, %xmm3
               	leaq	0x180(%rsp), %rdx
               	movss	%xmm0, (%rdx)
               	movss	%xmm1, 0x4(%rdx)
               	movss	%xmm2, 0x8(%rdx)
               	movss	%xmm3, 0xc(%rdx)
               	leaq	0x190(%rsp), %rcx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movss	(%rcx), %xmm0
               	movss	(%rax), %xmm1
               	mulss	%xmm1, %xmm0
               	movss	0x4(%rcx), %xmm1
               	movss	0x4(%rax), %xmm2
               	mulss	%xmm2, %xmm1
               	movss	0x8(%rcx), %xmm2
               	movss	0x8(%rax), %xmm3
               	mulss	%xmm3, %xmm2
               	movss	0xc(%rcx), %xmm3
               	movss	0xc(%rax), %xmm4
               	mulss	%xmm4, %xmm3
               	movss	%xmm0, (%rcx)
               	movss	%xmm1, 0x4(%rcx)
               	movss	%xmm2, 0x8(%rcx)
               	movss	%xmm3, 0xc(%rcx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rsi
               	leaq	0x90(%rsp), %rax
               	movss	(%rsi), %xmm0
               	movss	(%rax), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x4(%rsi), %xmm1
               	movss	0x4(%rax), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rsi), %xmm2
               	movss	0x8(%rax), %xmm3
               	addss	%xmm3, %xmm2
               	movss	0xc(%rsi), %xmm3
               	movss	0xc(%rax), %xmm4
               	addss	%xmm4, %xmm3
               	leaq	0x1a0(%rsp), %rdx
               	movss	%xmm0, (%rdx)
               	movss	%xmm1, 0x4(%rdx)
               	movss	%xmm2, 0x8(%rdx)
               	movss	%xmm3, 0xc(%rdx)
               	leaq	0x1b0(%rsp), %rcx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movss	(%rcx), %xmm0
               	movss	(%rax), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x4(%rcx), %xmm1
               	movss	0x4(%rax), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rcx), %xmm2
               	movss	0x8(%rax), %xmm3
               	addss	%xmm3, %xmm2
               	movss	0xc(%rcx), %xmm3
               	movss	0xc(%rax), %xmm4
               	addss	%xmm4, %xmm3
               	movss	%xmm0, (%rcx)
               	movss	%xmm1, 0x4(%rcx)
               	movss	%xmm2, 0x8(%rcx)
               	movss	%xmm3, 0xc(%rcx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0xa0(%rsp), %rsi
               	leaq	0xb0(%rsp), %rax
               	movsd	(%rsi), %xmm0
               	movsd	(%rax), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	0x8(%rsi), %xmm1
               	movsd	0x8(%rax), %xmm2
               	divsd	%xmm2, %xmm1
               	leaq	0x1c0(%rsp), %rdx
               	movsd	%xmm0, (%rdx)
               	movsd	%xmm1, 0x8(%rdx)
               	leaq	0x1d0(%rsp), %rcx
               	pushq	%rax
               	movq	(%rsi), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rsi), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movsd	(%rcx), %xmm0
               	movsd	(%rax), %xmm1
               	divsd	%xmm1, %xmm0
               	movsd	0x8(%rcx), %xmm1
               	movsd	0x8(%rax), %xmm2
               	divsd	%xmm2, %xmm1
               	movsd	%xmm0, (%rcx)
               	movsd	%xmm1, 0x8(%rcx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rdx
               	leaq	0x1e0(%rsp), %rcx
               	pushq	%rax
               	movq	(%rdx), %rax
               	movq	%rax, (%rcx)
               	movq	0x8(%rdx), %rax
               	movq	%rax, 0x8(%rcx)
               	popq	%rax
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movss	(%rcx), %xmm0
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	0x4(%rcx), %xmm1
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	movss	0x8(%rcx), %xmm2
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm2
               	movss	0xc(%rcx), %xmm3
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm3
               	movss	%xmm0, (%rcx)
               	movss	%xmm1, 0x4(%rcx)
               	movss	%xmm2, 0x8(%rcx)
               	movss	%xmm3, 0xc(%rcx)
               	movss	(%rdx), %xmm0
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm0
               	movss	0x4(%rdx), %xmm1
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm1
               	movss	0x8(%rdx), %xmm2
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm2
               	movss	0xc(%rdx), %xmm3
               	movq	%rax, %xmm15
               	mulss	%xmm15, %xmm3
               	leaq	0x1f0(%rsp), %rdx
               	movss	%xmm0, (%rdx)
               	movss	%xmm1, 0x4(%rdx)
               	movss	%xmm2, 0x8(%rdx)
               	movss	%xmm3, 0xc(%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rax
               	movss	(%rax), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	0x4(%rax), %xmm1
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	movss	0x8(%rax), %xmm2
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm2
               	movss	0xc(%rax), %xmm3
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm3
               	leaq	0x200(%rsp), %rcx
               	movss	%xmm0, (%rcx)
               	movss	%xmm1, 0x4(%rcx)
               	movss	%xmm2, 0x8(%rcx)
               	movss	%xmm3, 0xc(%rcx)
               	leaq	-0x450(%rbp), %rdx
               	movss	(%rax), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, (%rdx)
               	movss	0x4(%rax), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x4(%rdx)
               	movss	0x8(%rax), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0x8(%rdx)
               	movss	0xc(%rax), %xmm0
               	movl	$0x80000000, %r10d      # imm = 0x80000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movss	%xmm0, 0xc(%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x200(%rsp), %rax
               	movzbq	0xf(%rax), %rax
               	xorq	$0x80, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x14, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	leaq	0xa0(%rsp), %rax
               	movsd	(%rax), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	0x8(%rax), %xmm1
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm1
               	leaq	0x210(%rsp), %rcx
               	movsd	%xmm0, (%rcx)
               	movsd	%xmm1, 0x8(%rcx)
               	leaq	-0x488(%rbp), %rdx
               	movsd	(%rax), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	%xmm0, (%rdx)
               	movsd	0x8(%rax), %xmm0
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm0
               	movsd	%xmm0, 0x8(%rdx)
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rdx
               	leaq	0x90(%rsp), %rsi
               	movss	(%rdx), %xmm0
               	movss	(%rsi), %xmm1
               	addss	%xmm1, %xmm0
               	movss	0x4(%rdx), %xmm1
               	movss	0x4(%rsi), %xmm2
               	addss	%xmm2, %xmm1
               	movss	0x8(%rdx), %xmm2
               	movss	0x8(%rsi), %xmm3
               	addss	%xmm3, %xmm2
               	movss	0xc(%rdx), %xmm3
               	movss	0xc(%rsi), %xmm4
               	addss	%xmm4, %xmm3
               	movl	$0x40000000, %eax       # imm = 0x40000000
               	movss	(%rdx), %xmm4
               	movapd	%xmm0, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm4, %xmm0
               	vfmsub231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	movss	0x4(%rdx), %xmm4
               	movapd	%xmm1, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm4, %xmm1
               	vfmsub231ss	%xmm15, %xmm14, %xmm1 # xmm1 = (xmm14 * xmm15) - xmm1
               	movss	0x8(%rdx), %xmm4
               	movapd	%xmm2, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm4, %xmm2
               	vfmsub231ss	%xmm15, %xmm14, %xmm2 # xmm2 = (xmm14 * xmm15) - xmm2
               	movss	0xc(%rdx), %xmm4
               	movapd	%xmm3, %xmm14
               	movq	%rax, %xmm15
               	movapd	%xmm4, %xmm3
               	vfmsub231ss	%xmm15, %xmm14, %xmm3 # xmm3 = (xmm14 * xmm15) - xmm3
               	leaq	0x220(%rsp), %rax
               	movss	%xmm0, (%rax)
               	movss	%xmm1, 0x4(%rax)
               	movss	%xmm2, 0x8(%rax)
               	movss	%xmm3, 0xc(%rax)
               	xorl	%eax, %eax
               	leaq	-0x4b8(%rbp), %rdi
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	addq	%rcx, %rdi
               	leaq	(%rdx,%rcx), %r8
               	movss	(%r8), %xmm0
               	addq	%rsi, %rcx
               	movss	(%rcx), %xmm1
               	movapd	%xmm1, %xmm15
               	movapd	%xmm0, %xmm1
               	addss	%xmm15, %xmm1
               	movl	$0x40000000, %ecx       # imm = 0x40000000
               	movapd	%xmm1, %xmm14
               	movq	%rcx, %xmm15
               	vfmsub231ss	%xmm15, %xmm14, %xmm0 # xmm0 = (xmm14 * xmm15) - xmm0
               	movss	%xmm0, (%rdi)
               	incq	%rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	leaq	0x220(%rsp), %rcx
               	leaq	-0x4b8(%rbp), %rdx
               	xorl	%eax, %eax
               	movzbq	(%rcx,%rax), %rsi
               	movzbq	(%rdx,%rax), %rdi
               	cmpl	%edi, %esi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	movl	$0x16, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	movl	$0x15, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	movl	$0x13, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	movl	$0x12, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	movl	$0x11, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	movl	$0x10, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	movl	$0xf, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	movl	$0xe, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	movl	$0xd, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	movl	$0xc, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	movl	$0xb, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	movl	$0xa, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	movl	$0x9, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	movl	$0x8, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	movl	$0x7, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	movl	$0x6, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	movl	$0x5, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	movl	$0x4, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	movl	$0x3, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	movl	$0x2, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x8d0(%rbp), %rsp
               	leave
               	retq
