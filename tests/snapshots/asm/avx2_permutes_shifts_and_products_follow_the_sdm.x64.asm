
avx2_permutes_shifts_and_products_follow_the_sdm.x64:	file format elf64-x86-64

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

<_mm256_loadu_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	leaq	(%rsp), %rcx
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	-0x20(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_set_epi64x>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rdi, -0x50(%rbp)
               	movq	-0x50(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movq	%r8, (%rax)
               	movq	$0x2, 0x8(%rax)
               	movq	$-0x1, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	leave
               	retq

<_mm256_set_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x60(%rbp)
               	movq	-0x60(%rbp), %rax
               	leaq	(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movl	0x20(%rbp), %r9d
               	movl	%r9d, (%rsp)
               	movl	0x18(%rbp), %r9d
               	movl	%r9d, 0x4(%rsp)
               	movl	0x10(%rbp), %r9d
               	movl	%r9d, 0x8(%rsp)
               	movl	$0x7fffffff, 0xc(%rsp)  # imm = 0x7FFFFFFF
               	movl	$0x3, 0x10(%rsp)
               	leaq	(%rsp), %rdi
               	movl	$0xfffffffe, 0x14(%rsp) # imm = 0xFFFFFFFE
               	movl	$0x1, 0x18(%rsp)
               	movl	%esi, 0x1c(%rsp)
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_setr_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x60(%rbp)
               	movq	-0x60(%rbp), %rax
               	leaq	(%rsp), %r9
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r9)
               	movups	%xmm14, 0x10(%r9)
               	movl	%esi, (%rsp)
               	movl	$0x1, 0x4(%rsp)
               	movl	$0xfffffffe, 0x8(%rsp)  # imm = 0xFFFFFFFE
               	movl	$0x3, 0xc(%rsp)
               	leaq	(%rsp), %rcx
               	movl	$0x7fffffff, 0x10(%rsp) # imm = 0x7FFFFFFF
               	movl	0x10(%rbp), %edx
               	movl	%edx, 0x14(%rsp)
               	movl	0x18(%rbp), %edx
               	movl	%edx, 0x18(%rsp)
               	movl	0x20(%rbp), %edx
               	movl	%edx, 0x1c(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_setr_epi8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x60, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x60(%rbp)
               	movsbq	%sil, %rsi
               	movsbq	%r9b, %r9
               	movsbq	%r8b, %r8
               	movsbq	%cl, %rcx
               	movsbq	%dl, %rdx
               	movq	-0x60(%rbp), %rax
               	leaq	(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movb	%sil, (%rsp)
               	movb	%dl, 0x1(%rsp)
               	movb	%cl, 0x2(%rsp)
               	movb	%r8b, 0x3(%rsp)
               	movb	%r9b, 0x4(%rsp)
               	movsbq	0x10(%rbp), %rcx
               	movb	%cl, 0x5(%rsp)
               	movsbq	0x18(%rbp), %rcx
               	movb	%cl, 0x6(%rsp)
               	movsbq	0x20(%rbp), %rcx
               	movb	%cl, 0x7(%rsp)
               	movsbq	0x28(%rbp), %rcx
               	movb	%cl, 0x8(%rsp)
               	movsbq	0x30(%rbp), %rcx
               	movb	%cl, 0x9(%rsp)
               	movsbq	0x38(%rbp), %rcx
               	movb	%cl, 0xa(%rsp)
               	movsbq	0x40(%rbp), %rcx
               	movb	%cl, 0xb(%rsp)
               	movsbq	0x48(%rbp), %rcx
               	movb	%cl, 0xc(%rsp)
               	movsbq	0x50(%rbp), %rcx
               	movb	%cl, 0xd(%rsp)
               	movsbq	0x58(%rbp), %rcx
               	movb	%cl, 0xe(%rsp)
               	movsbq	0x60(%rbp), %rcx
               	movb	%cl, 0xf(%rsp)
               	movsbq	0x68(%rbp), %rcx
               	movb	%cl, 0x10(%rsp)
               	movsbq	0x70(%rbp), %rcx
               	movb	%cl, 0x11(%rsp)
               	movsbq	0x78(%rbp), %rcx
               	movb	%cl, 0x12(%rsp)
               	movsbq	0x80(%rbp), %rcx
               	movb	%cl, 0x13(%rsp)
               	movsbq	0x88(%rbp), %rcx
               	movb	%cl, 0x14(%rsp)
               	movsbq	0x90(%rbp), %rcx
               	movb	%cl, 0x15(%rsp)
               	movsbq	0x98(%rbp), %rcx
               	movb	%cl, 0x16(%rsp)
               	movsbq	0xa0(%rbp), %rcx
               	movb	%cl, 0x17(%rsp)
               	movsbq	0xa8(%rbp), %rcx
               	movb	%cl, 0x18(%rsp)
               	movsbq	0xb0(%rbp), %rcx
               	movb	%cl, 0x19(%rsp)
               	movsbq	0xb8(%rbp), %rcx
               	movb	%cl, 0x1a(%rsp)
               	movsbq	0xc0(%rbp), %rcx
               	movb	%cl, 0x1b(%rsp)
               	movsbq	0xc8(%rbp), %rcx
               	leaq	(%rsp), %rdx
               	movb	%cl, 0x1c(%rsp)
               	movsbq	0xd0(%rbp), %rcx
               	movb	%cl, 0x1d(%rsp)
               	movsbq	0xd8(%rbp), %rcx
               	movb	%cl, 0x1e(%rsp)
               	movsbq	0xe0(%rbp), %rcx
               	movb	%cl, 0x1f(%rsp)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_set_epi8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x128, %rsp            # imm = 0x128
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x60(%rbp)
               	movsbq	%sil, %rsi
               	movl	$0x1, %eax
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	movl	$0x4, %edi
               	movq	-0x60(%rbp), %rbx
               	leaq	(%rsp), %r8
               	movsbq	0xe0(%rbp), %r9
               	movsbq	0xd8(%rbp), %r12
               	movsbq	0xd0(%rbp), %r13
               	movsbq	0xc8(%rbp), %r14
               	movsbq	0xc0(%rbp), %r15
               	movsbq	0xb8(%rbp), %r10
               	movq	%r10, -0x68(%rbp)
               	movsbq	0xb0(%rbp), %r10
               	movq	%r10, -0x70(%rbp)
               	movsbq	0xa8(%rbp), %r10
               	movq	%r10, -0x78(%rbp)
               	movsbq	0xa0(%rbp), %r10
               	movq	%r10, -0x80(%rbp)
               	movsbq	0x98(%rbp), %r10
               	movq	%r10, -0x88(%rbp)
               	movsbq	0x90(%rbp), %r10
               	movq	%r10, -0x90(%rbp)
               	movsbq	0x88(%rbp), %r10
               	movq	%r10, -0x98(%rbp)
               	movsbq	0x80(%rbp), %r10
               	movq	%r10, -0xa0(%rbp)
               	movsbq	0x78(%rbp), %r10
               	movq	%r10, -0xa8(%rbp)
               	movsbq	0x70(%rbp), %r10
               	movq	%r10, -0xb0(%rbp)
               	movsbq	0x68(%rbp), %r10
               	movq	%r10, -0xb8(%rbp)
               	movsbq	0x60(%rbp), %r10
               	movq	%r10, -0xc0(%rbp)
               	movsbq	0x58(%rbp), %r10
               	movq	%r10, -0xc8(%rbp)
               	movsbq	0x50(%rbp), %r10
               	movq	%r10, -0xd0(%rbp)
               	movsbq	0x48(%rbp), %r10
               	movq	%r10, -0xd8(%rbp)
               	movsbq	0x40(%rbp), %r10
               	movq	%r10, -0xe0(%rbp)
               	movsbq	0x38(%rbp), %r10
               	movq	%r10, -0xe8(%rbp)
               	movsbq	0x30(%rbp), %r10
               	movq	%r10, -0xf0(%rbp)
               	movsbq	0x28(%rbp), %r10
               	movq	%r10, -0xf8(%rbp)
               	movsbq	0x20(%rbp), %r10
               	movq	%r10, -0x100(%rbp)
               	movsbq	0x18(%rbp), %r10
               	movq	%r10, -0x108(%rbp)
               	movsbq	0x10(%rbp), %r10
               	movq	%r10, -0x110(%rbp)
               	subq	$0xe0, %rsp
               	movq	-0x68(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	-0x70(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	-0x78(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	-0x80(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x88(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	-0x90(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	-0x98(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	-0xa0(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0xa8(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	-0xb0(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	-0xb8(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	-0xc0(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	-0xc8(%rbp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	-0xd0(%rbp), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	-0xd8(%rbp), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	-0xe0(%rbp), %r10
               	movq	%r10, 0x78(%rsp)
               	movq	-0xe8(%rbp), %r10
               	movq	%r10, 0x80(%rsp)
               	movq	-0xf0(%rbp), %r10
               	movq	%r10, 0x88(%rsp)
               	movq	-0xf8(%rbp), %r10
               	movq	%r10, 0x90(%rsp)
               	movq	-0x100(%rbp), %r10
               	movq	%r10, 0x98(%rsp)
               	movq	-0x108(%rbp), %r10
               	movq	%r10, 0xa0(%rsp)
               	movq	-0x110(%rbp), %r10
               	movq	%r10, 0xa8(%rsp)
               	movq	%rdi, 0xb0(%rsp)
               	movq	%rdx, 0xb8(%rsp)
               	movq	%rcx, 0xc0(%rsp)
               	movq	%rax, 0xc8(%rsp)
               	movq	%rsi, 0xd0(%rsp)
               	movq	%r8, %rdi
               	movq	%r9, %rsi
               	movq	%r14, %r8
               	movq	%r13, %rcx
               	movq	%r12, %rdx
               	movq	%r15, %r9
               	callq	<addr>
               	addq	$0xe0, %rsp
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rbx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rbx)
               	movq	%rbx, %rax
               	leaq	-0x150(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<_mm256_set_m128i>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movups	%xmm0, 0x20(%rsp)
               	movups	%xmm1, 0x30(%rsp)
               	movq	-0x30(%rbp), %rax
               	leaq	(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x30(%rsp), %rcx
               	movq	%rcx, (%rsp)
               	movq	0x38(%rsp), %rcx
               	movq	%rcx, 0x8(%rsp)
               	movq	0x20(%rsp), %rcx
               	movq	%rcx, 0x10(%rsp)
               	movq	0x28(%rsp), %rcx
               	movq	%rcx, 0x18(%rsp)
               	leaq	(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_zextsi128_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movups	%xmm0, 0x20(%rsp)
               	movq	-0x20(%rbp), %rax
               	leaq	(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x20(%rsp), %rdx
               	movq	%rdx, (%rsp)
               	movq	0x28(%rsp), %rdx
               	movq	%rdx, 0x8(%rsp)
               	movq	$0x0, 0x10(%rsp)
               	leaq	(%rsp), %rdx
               	movq	$0x0, 0x18(%rsp)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_broadcastsi128_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movups	%xmm0, 0x20(%rsp)
               	movq	-0x20(%rbp), %rax
               	leaq	(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x20(%rsp), %rcx
               	movq	%rcx, (%rsp)
               	movq	0x28(%rsp), %rdx
               	movq	%rdx, 0x8(%rsp)
               	movq	%rcx, 0x10(%rsp)
               	leaq	(%rsp), %rcx
               	movq	%rdx, 0x18(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_cmpgt_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rax
               	leaq	0x40(%rsp), %rcx
               	movl	(%rsp), %edx
               	movl	0x20(%rsp), %esi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x40(%rsp)
               	movl	0x4(%rsp), %edx
               	movl	0x24(%rsp), %esi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x44(%rsp)
               	movl	0x8(%rsp), %edx
               	movl	0x28(%rsp), %esi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x48(%rsp)
               	movl	0xc(%rsp), %edx
               	movl	0x2c(%rsp), %esi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x4c(%rsp)
               	movl	0x10(%rsp), %edx
               	movl	0x30(%rsp), %esi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x50(%rsp)
               	movl	0x14(%rsp), %edx
               	movl	0x34(%rsp), %esi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x54(%rsp)
               	movl	0x18(%rsp), %edx
               	movl	0x38(%rsp), %esi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x58(%rsp)
               	movl	0x1c(%rsp), %edx
               	movl	0x3c(%rsp), %esi
               	cmpl	%esi, %edx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movl	%edx, 0x5c(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_cmpgt_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rax
               	movq	(%rsp), %rcx
               	movq	0x20(%rsp), %rdx
               	cmpq	%rdx, %rcx
               	setg	%cl
               	movzbq	%cl, %rcx
               	negq	%rcx
               	movq	0x8(%rsp), %rdx
               	movq	0x28(%rsp), %rsi
               	cmpq	%rsi, %rdx
               	setg	%dl
               	movzbq	%dl, %rdx
               	negq	%rdx
               	movq	0x10(%rsp), %rsi
               	movq	0x30(%rsp), %rdi
               	cmpq	%rdi, %rsi
               	setg	%sil
               	movzbq	%sil, %rsi
               	negq	%rsi
               	movq	0x18(%rsp), %rdi
               	movq	0x38(%rsp), %r8
               	cmpq	%r8, %rdi
               	setg	%dil
               	movzbq	%dil, %rdi
               	negq	%rdi
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leave
               	retq

<_mm256_extract_epi8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	andq	$0x1f, %rdi
               	movzbq	(%rax,%rdi), %rax
               	leave
               	retq

<_mm256_extract_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	andq	$0x7, %rdi
               	movl	(%rax,%rdi,4), %eax
               	leave
               	retq

<_mm256_insert_epi8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	andq	$0x1f, %rdx
               	movb	%sil, (%rcx,%rdx)
               	movq	-0x30(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_insert_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movl	%esi, 0x38(%rsp)
               	movq	-0x30(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_extract_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	andq	$0x3, %rdi
               	movq	(%rax,%rdi,8), %rax
               	leave
               	retq

<_mm256_insert_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	subq	$0x20, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x30(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rcx
               	movq	%rsi, 0x10(%rsp)
               	movq	-0x30(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_mullo_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rax
               	leaq	0x40(%rsp), %rcx
               	movl	(%rsp), %edx
               	movl	0x20(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0x40(%rsp)
               	movl	0x4(%rsp), %edx
               	movl	0x24(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0x44(%rsp)
               	movl	0x8(%rsp), %edx
               	movl	0x28(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0x48(%rsp)
               	movl	0xc(%rsp), %edx
               	movl	0x2c(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0x4c(%rsp)
               	movl	0x10(%rsp), %edx
               	movl	0x30(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0x50(%rsp)
               	movl	0x14(%rsp), %edx
               	movl	0x34(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0x54(%rsp)
               	movl	0x18(%rsp), %edx
               	movl	0x38(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0x58(%rsp)
               	movl	0x1c(%rsp), %edx
               	movl	0x3c(%rsp), %esi
               	imulq	%rsi, %rdx
               	movl	%edx, 0x5c(%rsp)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_mul_epu32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	(%rsp), %rcx
               	movq	0x8(%rsp), %rdx
               	movq	0x10(%rsp), %rsi
               	movq	0x18(%rsp), %rdi
               	movq	0x20(%rsp), %r8
               	movq	0x28(%rsp), %r9
               	movq	0x30(%rsp), %rbx
               	movq	0x38(%rsp), %r12
               	movq	-0x10(%rbp), %rax
               	movl	%ecx, %ecx
               	movl	%edx, %edx
               	movl	%esi, %esi
               	movl	%edi, %edi
               	movl	%r8d, %r8d
               	movl	%r9d, %r9d
               	movl	%ebx, %ebx
               	movl	%r12d, %r12d
               	imulq	%r8, %rcx
               	imulq	%r9, %rdx
               	imulq	%rbx, %rsi
               	imulq	%r12, %rdi
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<_mm256_madd_epi16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x20(%rsp), %rax
               	leaq	0x60(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movswq	0x40(%rsp), %rax
               	movswq	0x60(%rsp), %rcx
               	imulq	%rcx, %rax
               	movswq	0x42(%rsp), %rcx
               	movswq	0x62(%rsp), %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	%eax, 0x80(%rsp)
               	movswq	0x44(%rsp), %rax
               	movswq	0x64(%rsp), %rcx
               	imulq	%rcx, %rax
               	movswq	0x46(%rsp), %rcx
               	movswq	0x66(%rsp), %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	%eax, 0x84(%rsp)
               	movswq	0x48(%rsp), %rax
               	movswq	0x68(%rsp), %rcx
               	imulq	%rcx, %rax
               	movswq	0x4a(%rsp), %rcx
               	movswq	0x6a(%rsp), %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	%eax, 0x88(%rsp)
               	movswq	0x4c(%rsp), %rax
               	movswq	0x6c(%rsp), %rcx
               	imulq	%rcx, %rax
               	movswq	0x4e(%rsp), %rcx
               	movswq	0x6e(%rsp), %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	%eax, 0x8c(%rsp)
               	movswq	0x50(%rsp), %rax
               	movswq	0x70(%rsp), %rcx
               	imulq	%rcx, %rax
               	movswq	0x52(%rsp), %rcx
               	movswq	0x72(%rsp), %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	%eax, 0x90(%rsp)
               	movswq	0x54(%rsp), %rax
               	movswq	0x74(%rsp), %rcx
               	imulq	%rcx, %rax
               	movswq	0x56(%rsp), %rcx
               	movswq	0x76(%rsp), %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	%eax, 0x94(%rsp)
               	movswq	0x58(%rsp), %rax
               	movswq	0x78(%rsp), %rcx
               	imulq	%rcx, %rax
               	movswq	0x5a(%rsp), %rcx
               	movswq	0x7a(%rsp), %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	%eax, 0x98(%rsp)
               	movswq	0x5c(%rsp), %rax
               	movswq	0x7c(%rsp), %rcx
               	imulq	%rcx, %rax
               	movswq	0x5e(%rsp), %rcx
               	movswq	0x7e(%rsp), %rdx
               	imulq	%rdx, %rcx
               	addq	%rcx, %rax
               	movl	%eax, 0x9c(%rsp)
               	movq	-0x10(%rbp), %rax
               	leaq	0x80(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_maddubs_epi16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x20(%rsp), %rax
               	leaq	0x60(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	shlq	%rax
               	movzbq	(%rdx,%rax), %rdi
               	movsbq	(%rsi,%rax), %r8
               	imulq	%r8, %rdi
               	leaq	0x40(%rsp), %r8
               	incq	%rax
               	movzbq	(%r8,%rax), %r8
               	leaq	0x60(%rsp), %r9
               	movsbq	(%r9,%rax), %rax
               	imulq	%r8, %rax
               	addq	%rdi, %rax
               	leaq	0x80(%rsp), %rdi
               	cmpl	$0x7fff, %eax           # imm = 0x7FFF
               	jle	<addr>
               	movl	$0x7fff, %eax           # imm = 0x7FFF
               	jmp	<addr>
               	cmpl	$0xffff8000, %eax       # imm = 0xFFFF8000
               	jge	<addr>
               	movq	$-0x8000, %rax          # imm = 0x8000
               	movw	%ax, (%rdi,%rcx,2)
               	incq	%rcx
               	cmpl	$0x10, %ecx
               	jl	<addr>
               	movq	-0x10(%rbp), %rax
               	leaq	0x80(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_sad_epu8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x18, %rsp
               	pushq	%rbx
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x40(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	leaq	0x20(%rsp), %rax
               	leaq	0x60(%rsp), %r8
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	xorl	%ebx, %ebx
               	xorl	%ecx, %ecx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movq	%rsi, %rax
               	leaq	0x8(%rsi), %rdx
               	cmpl	%edx, %eax
               	jge	<addr>
               	movzbq	(%rdi,%rax), %rdx
               	movzbq	(%r8,%rax), %r9
               	cmpl	%r9d, %edx
               	jle	<addr>
               	leaq	0x40(%rsp), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	leaq	0x60(%rsp), %r9
               	movzbq	(%r9,%rax), %r9
               	subq	%r9, %rdx
               	jmp	<addr>
               	leaq	0x60(%rsp), %rdx
               	movzbq	(%rdx,%rax), %rdx
               	leaq	0x40(%rsp), %r9
               	movzbq	(%r9,%rax), %r9
               	subq	%r9, %rdx
               	addq	%rdx, %rcx
               	incq	%rax
               	leaq	0x8(%rsi), %rdx
               	cmpl	%edx, %eax
               	jl	<addr>
               	leaq	0x80(%rsp), %rax
               	movq	%rcx, (%rax,%rbx,8)
               	incq	%rbx
               	cmpl	$0x4, %ebx
               	jl	<addr>
               	movq	-0x10(%rbp), %rax
               	leaq	0x80(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_subs_epu16>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x20(%rsp), %rax
               	leaq	0x60(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	xorl	%eax, %eax
               	leaq	0x80(%rsp), %rdi
               	movzwq	(%rdx,%rax,2), %rcx
               	movzwq	(%rsi,%rax,2), %r8
               	cmpl	%r8d, %ecx
               	jle	<addr>
               	movzwq	(%rdx,%rax,2), %rcx
               	movzwq	(%rsi,%rax,2), %r8
               	subq	%r8, %rcx
               	jmp	<addr>
               	xorl	%ecx, %ecx
               	movw	%cx, (%rdi,%rax,2)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	movq	-0x10(%rbp), %rax
               	leaq	0x80(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_slli_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x20(%rbp), %rax
               	cmpl	$0x1f, %esi
               	jbe	<addr>
               	leaq	0x20(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movups	%xmm14, 0x10(%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq
               	movl	%esi, %ecx
               	leaq	0x40(%rsp), %rdx
               	movl	(%rsp), %esi
               	shlxq	%rcx, %rsi, %rsi
               	movl	%esi, 0x40(%rsp)
               	movl	0x4(%rsp), %esi
               	shlxq	%rcx, %rsi, %rsi
               	movl	%esi, 0x44(%rsp)
               	movl	0x8(%rsp), %esi
               	shlxq	%rcx, %rsi, %rsi
               	movl	%esi, 0x48(%rsp)
               	movl	0xc(%rsp), %esi
               	shlxq	%rcx, %rsi, %rsi
               	movl	%esi, 0x4c(%rsp)
               	movl	0x10(%rsp), %esi
               	shlxq	%rcx, %rsi, %rsi
               	movl	%esi, 0x50(%rsp)
               	movl	0x14(%rsp), %esi
               	shlxq	%rcx, %rsi, %rsi
               	movl	%esi, 0x54(%rsp)
               	movl	0x18(%rsp), %esi
               	shlxq	%rcx, %rsi, %rsi
               	movl	%esi, 0x58(%rsp)
               	movl	0x1c(%rsp), %esi
               	shlxq	%rcx, %rsi, %rcx
               	movl	%ecx, 0x5c(%rsp)
               	jmp	<addr>

<_mm256_srli_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	-0x20(%rbp), %rax
               	cmpl	$0x1f, %esi
               	jbe	<addr>
               	leaq	0x20(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movups	%xmm14, 0x10(%rdx)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq
               	movl	%esi, %ecx
               	leaq	0x40(%rsp), %rdx
               	movl	(%rsp), %esi
               	shrxq	%rcx, %rsi, %rsi
               	movl	%esi, 0x40(%rsp)
               	movl	0x4(%rsp), %esi
               	shrxq	%rcx, %rsi, %rsi
               	movl	%esi, 0x44(%rsp)
               	movl	0x8(%rsp), %esi
               	shrxq	%rcx, %rsi, %rsi
               	movl	%esi, 0x48(%rsp)
               	movl	0xc(%rsp), %esi
               	shrxq	%rcx, %rsi, %rsi
               	movl	%esi, 0x4c(%rsp)
               	movl	0x10(%rsp), %esi
               	shrxq	%rcx, %rsi, %rsi
               	movl	%esi, 0x50(%rsp)
               	movl	0x14(%rsp), %esi
               	shrxq	%rcx, %rsi, %rsi
               	movl	%esi, 0x54(%rsp)
               	movl	0x18(%rsp), %esi
               	shrxq	%rcx, %rsi, %rsi
               	movl	%esi, 0x58(%rsp)
               	movl	0x1c(%rsp), %esi
               	shrxq	%rcx, %rsi, %rcx
               	movl	%ecx, 0x5c(%rsp)
               	jmp	<addr>

<_mm256_slli_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movslq	%esi, %rsi
               	movq	-0x20(%rbp), %rax
               	cmpl	$0x3f, %esi
               	jbe	<addr>
               	leaq	0x20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq
               	leaq	0x40(%rsp), %rcx
               	movq	(%rsp), %rdx
               	shlxq	%rsi, %rdx, %rdx
               	movq	%rdx, 0x40(%rsp)
               	movq	0x8(%rsp), %rdx
               	shlxq	%rsi, %rdx, %rdx
               	movq	%rdx, 0x48(%rsp)
               	movq	0x10(%rsp), %rdx
               	shlxq	%rsi, %rdx, %rdx
               	movq	%rdx, 0x50(%rsp)
               	movq	0x18(%rsp), %rdx
               	shlxq	%rsi, %rdx, %rdx
               	movq	%rdx, 0x58(%rsp)
               	jmp	<addr>

<_mm256_srli_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movslq	%esi, %rsi
               	movq	-0x20(%rbp), %rax
               	cmpl	$0x3f, %esi
               	jbe	<addr>
               	leaq	0x20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq
               	leaq	0x40(%rsp), %rcx
               	movq	(%rsp), %rdx
               	shrxq	%rsi, %rdx, %rdx
               	movq	%rdx, 0x40(%rsp)
               	movq	0x8(%rsp), %rdx
               	shrxq	%rsi, %rdx, %rdx
               	movq	%rdx, 0x48(%rsp)
               	movq	0x10(%rsp), %rdx
               	shrxq	%rsi, %rdx, %rdx
               	movq	%rdx, 0x50(%rsp)
               	movq	0x18(%rsp), %rdx
               	shrxq	%rsi, %rdx, %rdx
               	movq	%rdx, 0x58(%rsp)
               	jmp	<addr>

<_mm256_slli_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	andq	$0xff, %rsi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	0x40(%rsp), %r8
               	movq	%rax, %rdx
               	andq	$0xf, %rdx
               	cmpl	%esi, %edx
               	jb	<addr>
               	movq	%rax, %rdx
               	subq	%rsi, %rdx
               	movl	%edx, %edx
               	movzbq	(%rdi,%rdx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	movb	%dl, (%r8,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	-0x20(%rbp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_srli_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	andq	$0xff, %rsi
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	0x40(%rsp), %r8
               	movq	%rax, %rdx
               	andq	$0xf, %rdx
               	addq	%rsi, %rdx
               	cmpl	$0x10, %edx
               	jae	<addr>
               	leaq	(%rax,%rsi), %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	jmp	<addr>
               	movq	%rcx, %rdx
               	movb	%dl, (%r8,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	-0x20(%rbp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_shuffle_epi8>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x40(%rsp), %rsi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rsi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rsi)
               	leaq	0x20(%rsp), %rax
               	leaq	0x60(%rsp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	xorl	%ecx, %ecx
               	movq	%rcx, %rax
               	leaq	0x80(%rsp), %r8
               	movzbq	(%rdi,%rax), %rdx
               	testb	$-0x80, %dl
               	je	<addr>
               	movq	%rcx, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	andq	$0x10, %rdx
               	leaq	0x60(%rsp), %r9
               	movzbq	(%r9,%rax), %r9
               	andq	$0xf, %r9
               	orq	%r9, %rdx
               	movzbq	(%rsi,%rdx), %rdx
               	movb	%dl, (%r8,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	-0x10(%rbp), %rax
               	leaq	0x80(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_permutevar8x32_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movl	0x20(%rsp), %eax
               	movl	0x24(%rsp), %ecx
               	movl	0x28(%rsp), %edx
               	movl	0x2c(%rsp), %esi
               	movl	0x30(%rsp), %edi
               	movl	0x34(%rsp), %r8d
               	movl	0x38(%rsp), %r9d
               	movl	0x3c(%rsp), %ebx
               	leaq	0x40(%rsp), %r12
               	andq	$0x7, %rax
               	movl	(%r12,%rax,4), %eax
               	movl	%eax, 0x60(%rsp)
               	leaq	0x40(%rsp), %rax
               	andq	$0x7, %rcx
               	movl	(%rax,%rcx,4), %eax
               	movl	%eax, 0x64(%rsp)
               	leaq	0x40(%rsp), %rax
               	andq	$0x7, %rdx
               	movl	(%rax,%rdx,4), %eax
               	movl	%eax, 0x68(%rsp)
               	leaq	0x40(%rsp), %rax
               	andq	$0x7, %rsi
               	movl	(%rax,%rsi,4), %eax
               	movl	%eax, 0x6c(%rsp)
               	leaq	0x40(%rsp), %rax
               	andq	$0x7, %rdi
               	movl	(%rax,%rdi,4), %ecx
               	movl	%ecx, 0x70(%rsp)
               	andq	$0x7, %r8
               	movl	(%rax,%r8,4), %ecx
               	movl	%ecx, 0x74(%rsp)
               	andq	$0x7, %r9
               	movl	(%rax,%r9,4), %eax
               	movl	%eax, 0x78(%rsp)
               	leaq	0x60(%rsp), %rcx
               	leaq	0x40(%rsp), %rax
               	andq	$0x7, %rbx
               	movl	(%rax,%rbx,4), %eax
               	movl	%eax, 0x7c(%rsp)
               	movq	-0x10(%rbp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<_mm256_permute4x64_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movslq	%esi, %rsi
               	movq	-0x20(%rbp), %rax
               	leaq	0x20(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	leaq	(%rsp), %rcx
               	movq	%rsi, %rdx
               	andq	$0x3, %rdx
               	movq	(%rcx,%rdx,8), %rdx
               	movq	%rdx, 0x20(%rsp)
               	movq	%rsi, %rdx
               	sarq	$0x2, %rdx
               	andq	$0x3, %rdx
               	movq	(%rcx,%rdx,8), %rdx
               	movq	%rdx, 0x28(%rsp)
               	movq	%rsi, %rdx
               	sarq	$0x4, %rdx
               	andq	$0x3, %rdx
               	movq	(%rcx,%rdx,8), %rcx
               	leaq	0x20(%rsp), %rdx
               	movq	%rcx, 0x30(%rsp)
               	leaq	(%rsp), %rcx
               	sarq	$0x6, %rsi
               	andq	$0x3, %rsi
               	movq	(%rcx,%rsi,8), %rcx
               	movq	%rcx, 0x38(%rsp)
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_permute2x128_si256>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%rbx
               	subq	$0x80, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x20(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movslq	%esi, %rsi
               	xorl	%edi, %edi
               	movq	%rdi, %rax
               	movq	%rax, %rcx
               	shlq	$0x2, %rcx
               	sarxq	%rcx, %rsi, %rcx
               	testb	$0x2, %cl
               	je	<addr>
               	leaq	0x20(%rsp), %rdx
               	leaq	0x60(%rsp), %r8
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%r8)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%r8)
               	leaq	0x40(%rsp), %r9
               	movq	%rax, %rdx
               	shlq	%rdx
               	testb	$0x8, %cl
               	je	<addr>
               	movq	%rdi, %r8
               	movq	%r8, (%r9,%rdx,8)
               	leaq	0x40(%rsp), %r8
               	incq	%rdx
               	testb	$0x8, %cl
               	je	<addr>
               	xorl	%ecx, %ecx
               	jmp	<addr>
               	leaq	0x60(%rsp), %r9
               	andq	$0x1, %rcx
               	shlq	%rcx
               	incq	%rcx
               	movq	(%r9,%rcx,8), %rcx
               	jmp	<addr>
               	movq	%rcx, %rbx
               	andq	$0x1, %rbx
               	shlq	%rbx
               	movq	(%r8,%rbx,8), %r8
               	jmp	<addr>
               	leaq	(%rsp), %rdx
               	jmp	<addr>
               	movq	%rcx, (%r8,%rdx,8)
               	incq	%rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movq	-0x20(%rbp), %rax
               	leaq	0x40(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x30(%rbp), %rsp
               	popq	%rbx
               	leave
               	retq

<_mm256_unpacklo_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movl	(%rsp), %ecx
               	movl	0x4(%rsp), %edx
               	movl	0x10(%rsp), %esi
               	movl	0x14(%rsp), %edi
               	movl	0x20(%rsp), %r8d
               	movl	0x24(%rsp), %r9d
               	movl	0x30(%rsp), %ebx
               	movl	0x34(%rsp), %r12d
               	movq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movl	%ecx, (%rax)
               	movl	%r8d, 0x4(%rax)
               	movl	%edx, 0x8(%rax)
               	movl	%r9d, 0xc(%rax)
               	movl	%esi, 0x10(%rax)
               	movl	%ebx, 0x14(%rax)
               	movl	%edi, 0x18(%rax)
               	movl	%r12d, 0x1c(%rax)
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<_mm256_unpackhi_epi32>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movl	0x8(%rsp), %ecx
               	movl	0xc(%rsp), %edx
               	movl	0x18(%rsp), %esi
               	movl	0x1c(%rsp), %edi
               	movl	0x28(%rsp), %r8d
               	movl	0x2c(%rsp), %r9d
               	movl	0x38(%rsp), %ebx
               	movl	0x3c(%rsp), %r12d
               	movq	-0x10(%rbp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movl	%ecx, (%rax)
               	movl	%r8d, 0x4(%rax)
               	movl	%edx, 0x8(%rax)
               	movl	%r9d, 0xc(%rax)
               	movl	%esi, 0x10(%rax)
               	movl	%ebx, 0x14(%rax)
               	movl	%edi, 0x18(%rax)
               	movl	%r12d, 0x1c(%rax)
               	leaq	-0x20(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	leave
               	retq

<_mm256_unpacklo_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rax
               	leaq	0x40(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movq	(%rsp), %rcx
               	movq	%rcx, 0x40(%rsp)
               	movq	0x20(%rsp), %rcx
               	movq	%rcx, 0x48(%rsp)
               	movq	0x10(%rsp), %rcx
               	movq	%rcx, 0x50(%rsp)
               	movq	0x30(%rsp), %rcx
               	movq	%rcx, 0x58(%rsp)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<_mm256_unpackhi_epi64>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	subq	$0x60, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x10(%rbp)
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	movq	0x30(%rbp), %r10
               	movq	%r10, 0x20(%rsp)
               	movq	0x38(%rbp), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x40(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x48(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x10(%rbp), %rax
               	leaq	0x40(%rsp), %rcx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rcx)
               	movups	%xmm14, 0x10(%rcx)
               	movq	0x8(%rsp), %rcx
               	movq	%rcx, 0x40(%rsp)
               	movq	0x28(%rsp), %rcx
               	movq	%rcx, 0x48(%rsp)
               	movq	0x18(%rsp), %rcx
               	movq	%rcx, 0x50(%rsp)
               	movq	0x38(%rsp), %rcx
               	movq	%rcx, 0x58(%rsp)
               	leaq	0x40(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<round_of>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x128, %rsp            # imm = 0x128
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xa0, %rsp
               	andq	$-0x20, %rsp
               	leaq	-0x40(%rbp), %rdx
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %r8
               	shrq	$0x1b, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rsi, %rcx
               	movq	%rcx, %r8
               	shrq	$0x3c, %r8
               	cmpl	$0x4, %r8d
               	jae	<addr>
               	shrq	$0x3a, %rcx
               	andq	$0x3, %rcx
               	movzbq	(%rdi,%rcx), %rcx
               	jmp	<addr>
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rdx
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %r8
               	shrq	$0x1b, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rsi, %rcx
               	movq	%rcx, %r8
               	shrq	$0x3c, %r8
               	cmpl	$0x4, %r8d
               	jae	<addr>
               	shrq	$0x3a, %rcx
               	andq	$0x3, %rcx
               	movzbq	(%rdi,%rcx), %rcx
               	jmp	<addr>
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x60(%rbp), %rdx
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %r8
               	shrq	$0x1b, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rsi, %rcx
               	movq	%rcx, %r8
               	shrq	$0x3c, %r8
               	cmpl	$0x4, %r8d
               	jae	<addr>
               	shrq	$0x3a, %rcx
               	andq	$0x3, %rcx
               	movzbq	(%rdi,%rcx), %rcx
               	jmp	<addr>
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x50(%rbp), %rdx
               	movabsq	$0x2545f4914f6cdd1d, %rsi # imm = 0x2545F4914F6CDD1D
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %r8
               	shrq	$0xc, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %r8
               	shlq	$0x19, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %r8
               	shrq	$0x1b, %r8
               	xorq	%r8, %rcx
               	movq	%rcx, <rip> # <addr>
               	imulq	%rsi, %rcx
               	movq	%rcx, %r8
               	shrq	$0x3c, %r8
               	cmpl	$0x4, %r8d
               	jae	<addr>
               	shrq	$0x3a, %rcx
               	andq	$0x3, %rcx
               	movzbq	(%rdi,%rcx), %rcx
               	jmp	<addr>
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	callq	<addr>
               	leaq	0x60(%rsp), %rax
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x60(%rsp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	callq	<addr>
               	leaq	0x60(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x80(%rsp), %r9
               	leaq	-0x60(%rbp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	leaq	0x90(%rsp), %rax
               	leaq	-0x50(%rbp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	leaq	-0x68(%rbp), %rcx
               	leaq	-0x20(%rbp), %rax
               	movl	(%rax), %r10d
               	movl	%r10d, (%rcx)
               	leaq	-0x58(%rbp), %rcx
               	addq	$0x8, %rax
               	movq	(%rax), %r10
               	movq	%r10, (%rcx)
               	leaq	0x60(%rsp), %rdi
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	0x80(%rsp), %r9
               	leaq	0x90(%rsp), %rax
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	movq	%rax, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	0x80(%rsp), %r9
               	movq	%r9, %r10
               	movups	(%r10), %xmm0
               	callq	<addr>
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %r9
               	xorl	%edi, %edi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %r9
               	movl	$0x11, %edi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %r9
               	movl	$0x1f, %edi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %r9
               	movl	$0x2, %edi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %r9
               	movl	$0x7, %edi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movslq	%eax, %rax
               	movq	%rax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %r9
               	movl	$0x1, %edi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movq	%rax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	(%rsp), %r9
               	movl	$0x3, %edi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	movq	%rax, -0x48(%rbp)
               	movq	<rip>, %rcx # <addr>
               	leaq	-0x48(%rbp), %rdx
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	-0x68(%rbp), %esi
               	movl	$0x5, %edx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	-0x68(%rbp), %esi
               	movl	$0x1e, %edx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	-0x68(%rbp), %esi
               	movl	$0x6, %edx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movq	-0x58(%rbp), %rsi
               	movl	$0x2, %edx
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	xorl	%esi, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x31, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x12, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x83, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	movl	$0x28, %esi
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x1b, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	$0xd8, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	xorl	%esi, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x7, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x1f, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x20, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	$0xd, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x3f, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x40, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x5, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x20, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x21, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x40, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	xorl	%esi, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x3, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	$0xf, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x10, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x1, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x9, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	movl	$0x10, %esi
               	subq	$0x20, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	leaq	(%rsp), %r9
               	leaq	0x20(%rsp), %rax
               	subq	$0x40, %rsp
               	movq	%r9, %r10
               	movq	(%r10), %r11
               	movq	%r11, (%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x8(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x10(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x18(%rsp)
               	movq	%rax, %r10
               	movq	(%r10), %r11
               	movq	%r11, 0x20(%rsp)
               	movq	0x8(%r10), %r11
               	movq	%r11, 0x28(%rsp)
               	movq	0x10(%r10), %r11
               	movq	%r11, 0x30(%rsp)
               	movq	0x18(%r10), %r11
               	movq	%r11, 0x38(%rsp)
               	callq	<addr>
               	addq	$0x40, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	movl	-0x68(%rbp), %esi
               	movl	$0x1, %edx
               	movq	$-0x2, %rcx
               	movl	$0x3, %r8d
               	movl	$0x7fffffff, %r9d       # imm = 0x7FFFFFFF
               	movq	$-0x80000000, %rax      # imm = 0x80000000
               	movl	$0x6, %ebx
               	movzbq	-0x3d(%rbp), %r12
               	subq	$0x20, %rsp
               	movq	%rax, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	movq	%r12, 0x10(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	movl	-0x68(%rbp), %esi
               	movl	$0x1, %edx
               	movq	$-0x2, %rcx
               	movl	$0x3, %r8d
               	movl	$0x7fffffff, %r9d       # imm = 0x7FFFFFFF
               	movq	$-0x80000000, %rax      # imm = 0x80000000
               	movl	$0x6, %ebx
               	movzbq	-0x3d(%rbp), %r12
               	subq	$0x20, %rsp
               	movq	%rax, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	movq	%r12, 0x10(%rsp)
               	callq	<addr>
               	addq	$0x20, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	movq	-0x58(%rbp), %rsi
               	movq	$-0x1, %rdx
               	movl	$0x2, %ecx
               	movslq	-0x68(%rbp), %r8
               	callq	<addr>
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	movzbq	-0x40(%rbp), %rsi
               	movl	$0x1, %edx
               	movl	$0x2, %ecx
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	movl	$0x5, %eax
               	movl	$0x6, %ebx
               	movl	$0x7, %r12d
               	movl	$0x8, %r13d
               	movl	$0x9, %r14d
               	movl	$0xa, %r15d
               	movl	$0xb, %r10d
               	movq	%r10, -0x78(%rbp)
               	movl	$0xc, %r10d
               	movq	%r10, -0x80(%rbp)
               	movl	$0xd, %r10d
               	movq	%r10, -0x88(%rbp)
               	movl	$0xe, %r10d
               	movq	%r10, -0x90(%rbp)
               	movl	$0xf, %r10d
               	movq	%r10, -0x98(%rbp)
               	movl	$0x10, %r10d
               	movq	%r10, -0xa0(%rbp)
               	movl	$0x11, %r10d
               	movq	%r10, -0xa8(%rbp)
               	movl	$0x12, %r10d
               	movq	%r10, -0xb0(%rbp)
               	movl	$0x13, %r10d
               	movq	%r10, -0xb8(%rbp)
               	movl	$0x14, %r10d
               	movq	%r10, -0xc0(%rbp)
               	movl	$0x15, %r10d
               	movq	%r10, -0xc8(%rbp)
               	movl	$0x16, %r10d
               	movq	%r10, -0xd0(%rbp)
               	movl	$0x17, %r10d
               	movq	%r10, -0xd8(%rbp)
               	movl	$0x18, %r10d
               	movq	%r10, -0xe0(%rbp)
               	movl	$0x19, %r10d
               	movq	%r10, -0xe8(%rbp)
               	movl	$0x1a, %r10d
               	movq	%r10, -0xf0(%rbp)
               	movl	$0x1b, %r10d
               	movq	%r10, -0xf8(%rbp)
               	movl	$0x1c, %r10d
               	movq	%r10, -0x100(%rbp)
               	movl	$0x1d, %r10d
               	movq	%r10, -0x108(%rbp)
               	movl	$0x1e, %r10d
               	movq	%r10, -0x110(%rbp)
               	movq	$-0x80, %r10
               	movq	%r10, -0x118(%rbp)
               	subq	$0xe0, %rsp
               	movq	%rax, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	movq	%r12, 0x10(%rsp)
               	movq	%r13, 0x18(%rsp)
               	movq	%r14, 0x20(%rsp)
               	movq	%r15, 0x28(%rsp)
               	movq	-0x78(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	-0x80(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x88(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	-0x90(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	-0x98(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	-0xa0(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	-0xa8(%rbp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	-0xb0(%rbp), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	-0xb8(%rbp), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	-0xc0(%rbp), %r10
               	movq	%r10, 0x78(%rsp)
               	movq	-0xc8(%rbp), %r10
               	movq	%r10, 0x80(%rsp)
               	movq	-0xd0(%rbp), %r10
               	movq	%r10, 0x88(%rsp)
               	movq	-0xd8(%rbp), %r10
               	movq	%r10, 0x90(%rsp)
               	movq	-0xe0(%rbp), %r10
               	movq	%r10, 0x98(%rsp)
               	movq	-0xe8(%rbp), %r10
               	movq	%r10, 0xa0(%rsp)
               	movq	-0xf0(%rbp), %r10
               	movq	%r10, 0xa8(%rsp)
               	movq	-0xf8(%rbp), %r10
               	movq	%r10, 0xb0(%rsp)
               	movq	-0x100(%rbp), %r10
               	movq	%r10, 0xb8(%rsp)
               	movq	-0x108(%rbp), %r10
               	movq	%r10, 0xc0(%rsp)
               	movq	-0x110(%rbp), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	-0x118(%rbp), %r10
               	movq	%r10, 0xd0(%rsp)
               	callq	<addr>
               	addq	$0xe0, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x60(%rsp), %rdi
               	movzbq	-0x40(%rbp), %rsi
               	movl	$0x1, %edx
               	movl	$0x2, %ecx
               	movl	$0x3, %r8d
               	movl	$0x4, %r9d
               	movl	$0x5, %eax
               	movl	$0x6, %ebx
               	movl	$0x7, %r12d
               	movl	$0x8, %r13d
               	movl	$0x9, %r14d
               	movl	$0xa, %r15d
               	movl	$0xb, %r10d
               	movq	%r10, -0x78(%rbp)
               	movl	$0xc, %r10d
               	movq	%r10, -0x80(%rbp)
               	movl	$0xd, %r10d
               	movq	%r10, -0x88(%rbp)
               	movl	$0xe, %r10d
               	movq	%r10, -0x90(%rbp)
               	movl	$0xf, %r10d
               	movq	%r10, -0x98(%rbp)
               	movl	$0x10, %r10d
               	movq	%r10, -0xa0(%rbp)
               	movl	$0x11, %r10d
               	movq	%r10, -0xa8(%rbp)
               	movl	$0x12, %r10d
               	movq	%r10, -0xb0(%rbp)
               	movl	$0x13, %r10d
               	movq	%r10, -0xb8(%rbp)
               	movl	$0x14, %r10d
               	movq	%r10, -0xc0(%rbp)
               	movl	$0x15, %r10d
               	movq	%r10, -0xc8(%rbp)
               	movl	$0x16, %r10d
               	movq	%r10, -0xd0(%rbp)
               	movl	$0x17, %r10d
               	movq	%r10, -0xd8(%rbp)
               	movl	$0x18, %r10d
               	movq	%r10, -0xe0(%rbp)
               	movl	$0x19, %r10d
               	movq	%r10, -0xe8(%rbp)
               	movl	$0x1a, %r10d
               	movq	%r10, -0xf0(%rbp)
               	movl	$0x1b, %r10d
               	movq	%r10, -0xf8(%rbp)
               	movl	$0x1c, %r10d
               	movq	%r10, -0x100(%rbp)
               	movl	$0x1d, %r10d
               	movq	%r10, -0x108(%rbp)
               	movl	$0x1e, %r10d
               	movq	%r10, -0x110(%rbp)
               	movq	$-0x80, %r10
               	movq	%r10, -0x118(%rbp)
               	subq	$0xe0, %rsp
               	movq	%rax, (%rsp)
               	movq	%rbx, 0x8(%rsp)
               	movq	%r12, 0x10(%rsp)
               	movq	%r13, 0x18(%rsp)
               	movq	%r14, 0x20(%rsp)
               	movq	%r15, 0x28(%rsp)
               	movq	-0x78(%rbp), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	-0x80(%rbp), %r10
               	movq	%r10, 0x38(%rsp)
               	movq	-0x88(%rbp), %r10
               	movq	%r10, 0x40(%rsp)
               	movq	-0x90(%rbp), %r10
               	movq	%r10, 0x48(%rsp)
               	movq	-0x98(%rbp), %r10
               	movq	%r10, 0x50(%rsp)
               	movq	-0xa0(%rbp), %r10
               	movq	%r10, 0x58(%rsp)
               	movq	-0xa8(%rbp), %r10
               	movq	%r10, 0x60(%rsp)
               	movq	-0xb0(%rbp), %r10
               	movq	%r10, 0x68(%rsp)
               	movq	-0xb8(%rbp), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	-0xc0(%rbp), %r10
               	movq	%r10, 0x78(%rsp)
               	movq	-0xc8(%rbp), %r10
               	movq	%r10, 0x80(%rsp)
               	movq	-0xd0(%rbp), %r10
               	movq	%r10, 0x88(%rsp)
               	movq	-0xd8(%rbp), %r10
               	movq	%r10, 0x90(%rsp)
               	movq	-0xe0(%rbp), %r10
               	movq	%r10, 0x98(%rsp)
               	movq	-0xe8(%rbp), %r10
               	movq	%r10, 0xa0(%rsp)
               	movq	-0xf0(%rbp), %r10
               	movq	%r10, 0xa8(%rsp)
               	movq	-0xf8(%rbp), %r10
               	movq	%r10, 0xb0(%rsp)
               	movq	-0x100(%rbp), %r10
               	movq	%r10, 0xb8(%rsp)
               	movq	-0x108(%rbp), %r10
               	movq	%r10, 0xc0(%rsp)
               	movq	-0x110(%rbp), %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	-0x118(%rbp), %r10
               	movq	%r10, 0xd0(%rsp)
               	callq	<addr>
               	addq	$0xe0, %rsp
               	leaq	0x60(%rsp), %rax
               	leaq	0x40(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	movq	<rip>, %rcx # <addr>
               	movabsq	$0x100000001b3, %rsi    # imm = 0x100000001B3
               	xorl	%eax, %eax
               	movzbq	(%rdx,%rax), %rdi
               	xorq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	-0x150(%rbp), %rsp
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
               	subq	$0x8, %rsp
               	pushq	%rbx
               	xorl	%eax, %eax
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x340d631b7bdddcdb, %rdx # imm = 0xCBF29CE484222325
               	movq	%rdx, (%rcx,%rax,8)
               	incq	%rax
               	cmpl	$0x15, %eax
               	jl	<addr>
               	xorl	%ebx, %ebx
               	callq	<addr>
               	incq	%rbx
               	cmpl	$0x190, %ebx            # imm = 0x190
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	<rip>, %rdx # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	leaq	(%rsi,%rcx), %rdi
               	movq	(%rdi), %rdi
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rdi
               	jne	<addr>
               	incq	%rax
               	cmpl	$0x15, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
               	incq	%rax
               	popq	%rbx
               	leave
               	retq
