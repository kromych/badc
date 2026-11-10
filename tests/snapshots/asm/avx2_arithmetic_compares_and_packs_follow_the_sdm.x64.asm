
avx2_arithmetic_compares_and_packs_follow_the_sdm.x64:	file format elf64-x86-64

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

<__badc_lo_si>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	(%rsp), %rax
               	movq	%rax, 0x20(%rsp)
               	movq	0x8(%rsp), %rax
               	movq	%rax, 0x28(%rsp)
               	movups	0x20(%rsp), %xmm0
               	leave
               	retq

<__badc_hi_si>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	andq	$-0x20, %rsp
               	movq	0x10(%rbp), %r10
               	movq	%r10, (%rsp)
               	movq	0x18(%rbp), %r10
               	movq	%r10, 0x8(%rsp)
               	movq	0x20(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	0x28(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x20(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	0x10(%rsp), %rax
               	movq	%rax, 0x20(%rsp)
               	movq	0x18(%rsp), %rax
               	movq	%rax, 0x28(%rsp)
               	movups	0x20(%rsp), %xmm0
               	leave
               	retq

<__badc_join_si>:
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
               	movq	0x20(%rsp), %rcx
               	movq	%rcx, (%rsp)
               	movq	0x28(%rsp), %rcx
               	movq	%rcx, 0x8(%rsp)
               	movq	0x30(%rsp), %rcx
               	movq	%rcx, 0x10(%rsp)
               	movq	0x38(%rsp), %rcx
               	movq	%rcx, 0x18(%rsp)
               	leaq	(%rsp), %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leave
               	retq

<same>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
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
               	movq	%rdi, %rsi
               	leaq	-0x20(%rbp), %rdi
               	leaq	(%rsp), %rax
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	leave
               	retq

<check_saturating>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x160, %rsp            # imm = 0x160
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	(%rsp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rbx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	(%rsp), %rdi
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r12), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movq	(%rsp), %rdi
               	movq	0x8(%rsp), %r8
               	movq	0x10(%rsp), %r9
               	movq	0x18(%rsp), %r13
               	leaq	(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movups	%xmm14, 0x10(%r14)
               	movups	%xmm14, 0x20(%r14)
               	movups	%xmm14, 0x30(%r14)
               	movups	%xmm14, 0x40(%r14)
               	movups	%xmm14, 0x50(%r14)
               	movups	%xmm14, 0x60(%r14)
               	movups	%xmm14, 0x70(%r14)
               	movups	%xmm14, 0x80(%r14)
               	movups	%xmm14, 0x90(%r14)
               	movups	%xmm14, 0xa0(%r14)
               	movups	%xmm14, 0xb0(%r14)
               	movups	%xmm14, 0xc0(%r14)
               	movups	%xmm14, 0xd0(%r14)
               	movups	%xmm14, 0xe0(%r14)
               	movups	%xmm14, 0xf0(%r14)
               	leaq	0x120(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rax, 0x120(%rsp)
               	movq	%rcx, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm0
               	leaq	0x120(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdi, 0x120(%rsp)
               	movq	%r8, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm1
               	paddsb	%xmm1, %xmm0
               	leaq	0x130(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdx, 0x130(%rsp)
               	movq	%rsi, 0x138(%rsp)
               	movups	0x130(%rsp), %xmm1
               	leaq	0x130(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%r9, 0x130(%rsp)
               	movq	%r13, 0x138(%rsp)
               	movups	0x130(%rsp), %xmm2
               	paddsb	%xmm2, %xmm1
               	movups	%xmm0, 0x140(%rsp)
               	movups	%xmm1, 0x100(%rsp)
               	movq	0x140(%rsp), %r14
               	movq	0x148(%rsp), %r15
               	movq	0x100(%rsp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0x108(%rsp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	%r14, (%rsp)
               	movq	%r15, 0x8(%rsp)
               	movq	-0x48(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	-0x50(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0x120(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rax, 0x120(%rsp)
               	movq	%rcx, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm0
               	leaq	0x120(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdi, 0x120(%rsp)
               	movq	%r8, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm1
               	paddsw	%xmm1, %xmm0
               	leaq	0x130(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdx, 0x130(%rsp)
               	movq	%rsi, 0x138(%rsp)
               	movups	0x130(%rsp), %xmm1
               	leaq	0x130(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%r9, 0x130(%rsp)
               	movq	%r13, 0x138(%rsp)
               	movups	0x130(%rsp), %xmm2
               	paddsw	%xmm2, %xmm1
               	movups	%xmm0, 0x140(%rsp)
               	movups	%xmm1, 0x100(%rsp)
               	movq	0x140(%rsp), %r15
               	movq	0x148(%rsp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0x100(%rsp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	0x108(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	leaq	(%rsp), %r14
               	addq	$0x20, %r14
               	movq	%r15, (%r14)
               	movq	-0x48(%rbp), %r11
               	movq	%r11, 0x8(%r14)
               	movq	-0x50(%rbp), %r11
               	movq	%r11, 0x10(%r14)
               	movq	-0x58(%rbp), %r11
               	movq	%r11, 0x18(%r14)
               	leaq	0x120(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rax, 0x120(%rsp)
               	movq	%rcx, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm0
               	leaq	0x120(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdi, 0x120(%rsp)
               	movq	%r8, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm1
               	paddusb	%xmm1, %xmm0
               	leaq	0x130(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdx, 0x130(%rsp)
               	movq	%rsi, 0x138(%rsp)
               	movups	0x130(%rsp), %xmm1
               	leaq	0x130(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%r9, 0x130(%rsp)
               	movq	%r13, 0x138(%rsp)
               	movups	0x130(%rsp), %xmm2
               	paddusb	%xmm2, %xmm1
               	movups	%xmm0, 0x140(%rsp)
               	movups	%xmm1, 0x100(%rsp)
               	movq	0x140(%rsp), %r15
               	movq	0x148(%rsp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0x100(%rsp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	0x108(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	leaq	(%rsp), %r14
               	addq	$0x40, %r14
               	movq	%r15, (%r14)
               	movq	-0x48(%rbp), %r11
               	movq	%r11, 0x8(%r14)
               	movq	-0x50(%rbp), %r11
               	movq	%r11, 0x10(%r14)
               	movq	-0x58(%rbp), %r11
               	movq	%r11, 0x18(%r14)
               	leaq	0x120(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rax, 0x120(%rsp)
               	movq	%rcx, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm0
               	leaq	0x120(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdi, 0x120(%rsp)
               	movq	%r8, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm1
               	paddusw	%xmm1, %xmm0
               	leaq	0x130(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdx, 0x130(%rsp)
               	movq	%rsi, 0x138(%rsp)
               	movups	0x130(%rsp), %xmm1
               	leaq	0x130(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%r9, 0x130(%rsp)
               	movq	%r13, 0x138(%rsp)
               	movups	0x130(%rsp), %xmm2
               	paddusw	%xmm2, %xmm1
               	movups	%xmm0, 0x140(%rsp)
               	movups	%xmm1, 0x100(%rsp)
               	movq	0x140(%rsp), %r15
               	movq	0x148(%rsp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0x100(%rsp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	0x108(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	leaq	(%rsp), %r14
               	addq	$0x60, %r14
               	movq	%r15, (%r14)
               	movq	-0x48(%rbp), %r11
               	movq	%r11, 0x8(%r14)
               	movq	-0x50(%rbp), %r11
               	movq	%r11, 0x10(%r14)
               	movq	-0x58(%rbp), %r11
               	movq	%r11, 0x18(%r14)
               	leaq	0x120(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rax, 0x120(%rsp)
               	movq	%rcx, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm0
               	leaq	0x120(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdi, 0x120(%rsp)
               	movq	%r8, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm1
               	psubsb	%xmm1, %xmm0
               	leaq	0x130(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdx, 0x130(%rsp)
               	movq	%rsi, 0x138(%rsp)
               	movups	0x130(%rsp), %xmm1
               	leaq	0x130(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%r9, 0x130(%rsp)
               	movq	%r13, 0x138(%rsp)
               	movups	0x130(%rsp), %xmm2
               	psubsb	%xmm2, %xmm1
               	movups	%xmm0, 0x140(%rsp)
               	movups	%xmm1, 0x100(%rsp)
               	movq	0x140(%rsp), %r15
               	movq	0x148(%rsp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0x100(%rsp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	0x108(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	leaq	(%rsp), %r14
               	addq	$0x80, %r14
               	movq	%r15, (%r14)
               	movq	-0x48(%rbp), %r11
               	movq	%r11, 0x8(%r14)
               	movq	-0x50(%rbp), %r11
               	movq	%r11, 0x10(%r14)
               	movq	-0x58(%rbp), %r11
               	movq	%r11, 0x18(%r14)
               	leaq	0x120(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rax, 0x120(%rsp)
               	movq	%rcx, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm0
               	leaq	0x120(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdi, 0x120(%rsp)
               	movq	%r8, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm1
               	psubsw	%xmm1, %xmm0
               	leaq	0x130(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdx, 0x130(%rsp)
               	movq	%rsi, 0x138(%rsp)
               	movups	0x130(%rsp), %xmm1
               	leaq	0x130(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%r9, 0x130(%rsp)
               	movq	%r13, 0x138(%rsp)
               	movups	0x130(%rsp), %xmm2
               	psubsw	%xmm2, %xmm1
               	movups	%xmm0, 0x140(%rsp)
               	movups	%xmm1, 0x100(%rsp)
               	movq	0x140(%rsp), %r15
               	movq	0x148(%rsp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0x100(%rsp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	0x108(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	leaq	(%rsp), %r14
               	addq	$0xa0, %r14
               	movq	%r15, (%r14)
               	movq	-0x48(%rbp), %r11
               	movq	%r11, 0x8(%r14)
               	movq	-0x50(%rbp), %r11
               	movq	%r11, 0x10(%r14)
               	movq	-0x58(%rbp), %r11
               	movq	%r11, 0x18(%r14)
               	leaq	0x120(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rax, 0x120(%rsp)
               	movq	%rcx, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm0
               	leaq	0x120(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdi, 0x120(%rsp)
               	movq	%r8, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm1
               	psubusb	%xmm1, %xmm0
               	leaq	0x130(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdx, 0x130(%rsp)
               	movq	%rsi, 0x138(%rsp)
               	movups	0x130(%rsp), %xmm1
               	leaq	0x130(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%r9, 0x130(%rsp)
               	movq	%r13, 0x138(%rsp)
               	movups	0x130(%rsp), %xmm2
               	psubusb	%xmm2, %xmm1
               	movups	%xmm0, 0x140(%rsp)
               	movups	%xmm1, 0x100(%rsp)
               	movq	0x140(%rsp), %r15
               	movq	0x148(%rsp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0x100(%rsp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	0x108(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	leaq	(%rsp), %r14
               	addq	$0xc0, %r14
               	movq	%r15, (%r14)
               	movq	-0x48(%rbp), %r11
               	movq	%r11, 0x8(%r14)
               	movq	-0x50(%rbp), %r11
               	movq	%r11, 0x10(%r14)
               	movq	-0x58(%rbp), %r11
               	movq	%r11, 0x18(%r14)
               	leaq	0x120(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rax, 0x120(%rsp)
               	movq	%rcx, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm0
               	leaq	0x120(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdi, 0x120(%rsp)
               	movq	%r8, 0x128(%rsp)
               	movups	0x120(%rsp), %xmm1
               	psubusw	%xmm1, %xmm0
               	leaq	0x130(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0x130(%rsp)
               	leaq	0x130(%rsp), %rax
               	movq	%rsi, 0x138(%rsp)
               	movups	0x130(%rsp), %xmm1
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r9, 0x130(%rsp)
               	movq	%r13, 0x138(%rsp)
               	movups	0x130(%rsp), %xmm2
               	psubusw	%xmm2, %xmm1
               	movups	%xmm0, 0x140(%rsp)
               	movups	%xmm1, 0x100(%rsp)
               	movq	0x140(%rsp), %rcx
               	movq	0x148(%rsp), %rdx
               	movq	0x100(%rsp), %rsi
               	movq	0x108(%rsp), %rdi
               	leaq	(%rsp), %rax
               	addq	$0xe0, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	xorl	%r15d, %r15d
               	testb	$0x1, %r15b
               	je	<addr>
               	movl	$0x2, %ecx
               	movq	%r15, %r13
               	andq	$0x2, %r13
               	cmpl	$0x4, %r15d
               	setge	%r14b
               	movzbq	%r14b, %r14
               	xorl	%r9d, %r9d
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r9d
               	jge	<addr>
               	xorl	%edx, %edx
               	leaq	-0x1(%rcx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rdx
               	movq	%rcx, %rsi
               	imulq	%r9, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testl	%r13d, %r13d
               	jne	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	decq	%rax
               	shrxq	%rax, %rdx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	shlxq	%rsi, %rax, %rax
               	orq	%rax, %rdx
               	xorl	%r8d, %r8d
               	leaq	-0x1(%rcx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %r8
               	movq	%rcx, %rsi
               	imulq	%r9, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movzbq	(%r12,%rsi), %rsi
               	orq	%rsi, %r8
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testl	%r13d, %r13d
               	jne	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	decq	%rax
               	shrxq	%rax, %r8, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	shlxq	%rsi, %rax, %rax
               	orq	%rax, %r8
               	leaq	-0x40(%rbp), %rsi
               	testq	%r14, %r14
               	je	<addr>
               	movq	%rdx, %rax
               	subq	%r8, %rax
               	testl	%r13d, %r13d
               	jne	<addr>
               	movl	$0x1, %edx
               	movq	%rcx, %rdi
               	shlq	$0x3, %rdi
               	decq	%rdi
               	shlxq	%rdi, %rdx, %rdx
               	negq	%rdx
               	testl	%r13d, %r13d
               	jne	<addr>
               	movl	$0x1, %edi
               	movq	%rcx, %r8
               	shlq	$0x3, %r8
               	decq	%r8
               	shlxq	%r8, %rdi, %rdi
               	decq	%rdi
               	cmpq	%rdx, %rax
               	jge	<addr>
               	xorl	%eax, %eax
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	imulq	%r9, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	movslq	%r8d, %r8
               	shrxq	%r8, %rdx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rsi,%rdi)
               	incq	%rax
               	cmpl	%ecx, %eax
               	jge	<addr>
               	jmp	<addr>
               	cmpq	%rdi, %rax
               	jle	<addr>
               	movq	%rdi, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movl	$0x1, %edi
               	movq	%rcx, %r8
               	shlq	$0x3, %r8
               	shlxq	%r8, %rdi, %rdi
               	decq	%rdi
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	leaq	(%rdx,%r8), %rax
               	jmp	<addr>
               	incq	%r9
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r9d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	%r15, %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x100(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	incq	%r15
               	cmpl	$0x8, %r15d
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x1, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<check_products>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x118, %rsp            # imm = 0x118
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xe0, %rsp
               	andq	$-0x20, %rsp
               	xorl	%eax, %eax
               	leaq	-0x100(%rbp), %rcx
               	movzbq	(%rdi,%rax), %rdx
               	movzbq	(%rsi,%rax), %r8
               	addq	%r8, %rdx
               	incq	%rdx
               	sarq	%rdx
               	movb	%dl, (%rcx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	xorl	%edx, %edx
               	movl	$0x1, %ecx
               	shlq	$0x8, %rdx
               	movq	%rax, %r8
               	shlq	%r8
               	addq	%rcx, %r8
               	movslq	%r8d, %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rdx
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	movq	%rdx, %rcx
               	shrq	$0xf, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	orq	$-0x10000, %rdx         # imm = 0xFFFF0000
               	xorl	%r8d, %r8d
               	movl	$0x1, %ecx
               	shlq	$0x8, %r8
               	movq	%rax, %r9
               	shlq	%r9
               	addq	%rcx, %r9
               	movslq	%r9d, %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %r8
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	movq	%r8, %rcx
               	shrq	$0xf, %rcx
               	testb	$0x1, %cl
               	je	<addr>
               	orq	$-0x10000, %r8          # imm = 0xFFFF0000
               	movq	%rdx, %r9
               	imulq	%r8, %r9
               	xorl	%edx, %edx
               	movl	$0x1, %ecx
               	shlq	$0x8, %rdx
               	movq	%rax, %r8
               	shlq	%r8
               	addq	%rcx, %r8
               	movslq	%r8d, %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rdx
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	xorl	%r8d, %r8d
               	movl	$0x1, %ecx
               	shlq	$0x8, %r8
               	movq	%rax, %rbx
               	shlq	%rbx
               	addq	%rcx, %rbx
               	movslq	%ebx, %rbx
               	movzbq	(%rsi,%rbx), %rbx
               	orq	%rbx, %r8
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	movq	%rdx, %r13
               	imulq	%r8, %r13
               	leaq	-0xe0(%rbp), %rbx
               	xorl	%edx, %edx
               	movl	$0x1, %ecx
               	shlq	$0x8, %rdx
               	movq	%rax, %r8
               	shlq	%r8
               	addq	%rcx, %r8
               	movslq	%r8d, %r8
               	movzbq	(%rdi,%r8), %r8
               	orq	%r8, %rdx
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	xorl	%r8d, %r8d
               	movl	$0x1, %ecx
               	shlq	$0x8, %r8
               	movq	%rax, %r12
               	shlq	%r12
               	addq	%rcx, %r12
               	movslq	%r12d, %r12
               	movzbq	(%rsi,%r12), %r12
               	orq	%r12, %r8
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	leaq	(%rdx,%r8), %rcx
               	leaq	0x1(%rcx), %rdx
               	shrq	%rdx
               	xorl	%ecx, %ecx
               	movq	%rax, %r8
               	shlq	%r8
               	addq	%rcx, %r8
               	movslq	%r8d, %r8
               	movq	%rcx, %r12
               	shlq	$0x3, %r12
               	shrxq	%r12, %rdx, %r12
               	andq	$0xff, %r12
               	movb	%r12b, (%rbx,%r8)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	leaq	-0xc0(%rbp), %rdx
               	movq	%r9, %r8
               	sarq	$0x10, %r8
               	xorl	%ecx, %ecx
               	movq	%rax, %rbx
               	shlq	%rbx
               	addq	%rcx, %rbx
               	movslq	%ebx, %rbx
               	movq	%rcx, %r12
               	shlq	$0x3, %r12
               	shrxq	%r12, %r8, %r12
               	andq	$0xff, %r12
               	movb	%r12b, (%rdx,%rbx)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	leaq	-0xa0(%rbp), %rdx
               	movq	%r13, %r8
               	shrq	$0x10, %r8
               	xorl	%ecx, %ecx
               	movq	%rax, %rbx
               	shlq	%rbx
               	addq	%rcx, %rbx
               	movslq	%ebx, %rbx
               	movq	%rcx, %r12
               	shlq	$0x3, %r12
               	shrxq	%r12, %r8, %r12
               	andq	$0xff, %r12
               	movb	%r12b, (%rdx,%rbx)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	leaq	-0x80(%rbp), %rdx
               	movq	%r9, %rcx
               	sarq	$0xe, %rcx
               	leaq	0x1(%rcx), %r8
               	sarq	%r8
               	xorl	%ecx, %ecx
               	movq	%rax, %rbx
               	shlq	%rbx
               	addq	%rcx, %rbx
               	movslq	%ebx, %rbx
               	movq	%rcx, %r12
               	shlq	$0x3, %r12
               	shrxq	%r12, %r8, %r12
               	andq	$0xff, %r12
               	movb	%r12b, (%rdx,%rbx)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	leaq	-0x60(%rbp), %rdx
               	xorl	%ecx, %ecx
               	movq	%rax, %r8
               	shlq	%r8
               	addq	%rcx, %r8
               	movslq	%r8d, %r8
               	movq	%rcx, %rbx
               	shlq	$0x3, %rbx
               	shrxq	%rbx, %r9, %rbx
               	andq	$0xff, %rbx
               	movb	%bl, (%rdx,%r8)
               	incq	%rcx
               	cmpl	$0x2, %ecx
               	jl	<addr>
               	incq	%rax
               	cmpl	$0x10, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %r8
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	movzbq	(%rdi,%rax), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	orq	%r11, %rcx
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	movzbq	(%rsi,%rax), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdx, %rax
               	shrq	$0x1f, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	orq	%r11, %rdx
               	imulq	%rcx, %rdx
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	shrxq	%rcx, %rdx, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%r8,%rax)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %r8
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x8(%rax), %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	orq	%r11, %rcx
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0x8(%rax), %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdx, %rax
               	shrq	$0x1f, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	orq	%r11, %rdx
               	imulq	%rcx, %rdx
               	xorl	%eax, %eax
               	leaq	0x8(%rax), %rcx
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rdx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%r8,%rcx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %r8
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x10(%rax), %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	orq	%r11, %rcx
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0x10(%rax), %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdx, %rax
               	shrq	$0x1f, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	orq	%r11, %rdx
               	imulq	%rcx, %rdx
               	xorl	%eax, %eax
               	leaq	0x10(%rax), %rcx
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rdx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%r8,%rcx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %r8
               	xorl	%ecx, %ecx
               	movl	$0x3, %eax
               	shlq	$0x8, %rcx
               	leaq	0x18(%rax), %rdx
               	movzbq	(%rdi,%rdx), %rdx
               	orq	%rdx, %rcx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rcx, %rax
               	shrq	$0x1f, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	orq	%r11, %rcx
               	xorl	%edx, %edx
               	movl	$0x3, %eax
               	shlq	$0x8, %rdx
               	leaq	0x18(%rax), %r9
               	movzbq	(%rsi,%r9), %r9
               	orq	%r9, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	movq	%rdx, %rax
               	shrq	$0x1f, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movabsq	$-0x100000000, %r11     # imm = 0xFFFFFFFF00000000
               	orq	%r11, %rdx
               	imulq	%rcx, %rdx
               	xorl	%eax, %eax
               	leaq	0x18(%rax), %rcx
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	shrxq	%r9, %rdx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%r8,%rcx)
               	incq	%rax
               	cmpl	$0x8, %eax
               	jl	<addr>
               	leaq	0x40(%rsp), %rax
               	movups	(%rdi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x40(%rsp), %rax
               	movups	(%rsi), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rsi), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %rbx
               	leaq	0xc0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	leaq	0xc0(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdi, 0xc0(%rsp)
               	movq	%r8, 0xc8(%rsp)
               	movups	0xc0(%rsp), %xmm1
               	pavgb	%xmm1, %xmm0
               	leaq	0x80(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0x80(%rsp)
               	movq	%rsi, 0x88(%rsp)
               	movups	0x80(%rsp), %xmm1
               	leaq	0x80(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r9, 0x80(%rsp)
               	movq	%rbx, 0x88(%rsp)
               	movups	0x80(%rsp), %xmm2
               	pavgb	%xmm2, %xmm1
               	movups	%xmm0, 0xa0(%rsp)
               	movups	%xmm1, 0x40(%rsp)
               	movq	0xa0(%rsp), %rax
               	movq	0xa8(%rsp), %rcx
               	movq	0x40(%rsp), %rdx
               	movq	0x48(%rsp), %rdi
               	leaq	-0x100(%rbp), %rsi
               	leaq	0x60(%rsp), %r8
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rdx, 0x70(%rsp)
               	movq	%rdi, 0x78(%rsp)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r8), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %rbx
               	leaq	0xc0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	leaq	0xc0(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdi, 0xc0(%rsp)
               	movq	%r8, 0xc8(%rsp)
               	movups	0xc0(%rsp), %xmm1
               	pavgw	%xmm1, %xmm0
               	leaq	0x80(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0x80(%rsp)
               	movq	%rsi, 0x88(%rsp)
               	movups	0x80(%rsp), %xmm1
               	leaq	0x80(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r9, 0x80(%rsp)
               	movq	%rbx, 0x88(%rsp)
               	movups	0x80(%rsp), %xmm2
               	pavgw	%xmm2, %xmm1
               	movups	%xmm0, 0xa0(%rsp)
               	movups	%xmm1, 0x40(%rsp)
               	movq	0xa0(%rsp), %rax
               	movq	0xa8(%rsp), %rcx
               	movq	0x40(%rsp), %rdx
               	movq	0x48(%rsp), %rdi
               	leaq	-0xe0(%rbp), %rsi
               	leaq	0x60(%rsp), %r8
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rdx, 0x70(%rsp)
               	movq	%rdi, 0x78(%rsp)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r8), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %rbx
               	leaq	0xc0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	leaq	0xc0(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdi, 0xc0(%rsp)
               	movq	%r8, 0xc8(%rsp)
               	movups	0xc0(%rsp), %xmm1
               	pmulhw	%xmm1, %xmm0
               	leaq	0x80(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0x80(%rsp)
               	movq	%rsi, 0x88(%rsp)
               	movups	0x80(%rsp), %xmm1
               	leaq	0x80(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r9, 0x80(%rsp)
               	movq	%rbx, 0x88(%rsp)
               	movups	0x80(%rsp), %xmm2
               	pmulhw	%xmm2, %xmm1
               	movups	%xmm0, 0xa0(%rsp)
               	movups	%xmm1, 0x40(%rsp)
               	movq	0xa0(%rsp), %rax
               	movq	0xa8(%rsp), %rcx
               	movq	0x40(%rsp), %rdx
               	movq	0x48(%rsp), %rdi
               	leaq	-0xc0(%rbp), %rsi
               	leaq	0x60(%rsp), %r8
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rdx, 0x70(%rsp)
               	movq	%rdi, 0x78(%rsp)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r8), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %rbx
               	leaq	0xc0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	leaq	0xc0(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdi, 0xc0(%rsp)
               	movq	%r8, 0xc8(%rsp)
               	movups	0xc0(%rsp), %xmm1
               	pmulhuw	%xmm1, %xmm0
               	leaq	0x80(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0x80(%rsp)
               	movq	%rsi, 0x88(%rsp)
               	movups	0x80(%rsp), %xmm1
               	leaq	0x80(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r9, 0x80(%rsp)
               	movq	%rbx, 0x88(%rsp)
               	movups	0x80(%rsp), %xmm2
               	pmulhuw	%xmm2, %xmm1
               	movups	%xmm0, 0xa0(%rsp)
               	movups	%xmm1, 0x40(%rsp)
               	movq	0xa0(%rsp), %rax
               	movq	0xa8(%rsp), %rcx
               	movq	0x40(%rsp), %rdx
               	movq	0x48(%rsp), %rdi
               	leaq	-0xa0(%rbp), %rsi
               	leaq	0x60(%rsp), %r8
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rdx, 0x70(%rsp)
               	movq	%rdi, 0x78(%rsp)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r8), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %rbx
               	leaq	0xc0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	leaq	0xc0(%rsp), %rax
               	movups	0xc0(%rsp), %xmm0
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdi, 0xc0(%rsp)
               	movq	%r8, 0xc8(%rsp)
               	movups	0xc0(%rsp), %xmm1
               	pmulhrsw	%xmm1, %xmm0
               	leaq	0x80(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0x80(%rsp)
               	movq	%rsi, 0x88(%rsp)
               	movups	0x80(%rsp), %xmm1
               	leaq	0x80(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r9, 0x80(%rsp)
               	movq	%rbx, 0x88(%rsp)
               	movups	0x80(%rsp), %xmm2
               	pmulhrsw	%xmm2, %xmm1
               	movups	%xmm0, 0xa0(%rsp)
               	movups	%xmm1, 0x40(%rsp)
               	movq	0xa0(%rsp), %rax
               	movq	0xa8(%rsp), %rcx
               	movq	0x40(%rsp), %rdx
               	movq	0x48(%rsp), %rdi
               	leaq	-0x80(%rbp), %rsi
               	leaq	0x60(%rsp), %r8
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rdx, 0x70(%rsp)
               	movq	%rdi, 0x78(%rsp)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r8), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x80(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0xa0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	0x80(%rsp), %rax
               	movq	0x88(%rsp), %rcx
               	leaq	0xc0(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	movups	0xc0(%rsp), %xmm0
               	movq	0xa0(%rsp), %rax
               	movq	0xa8(%rsp), %rcx
               	leaq	0xc0(%rsp), %rdx
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdx)
               	movq	%rax, 0xc0(%rsp)
               	movq	%rcx, 0xc8(%rsp)
               	movups	0xc0(%rsp), %xmm1
               	pmullw	%xmm1, %xmm0
               	movups	%xmm0, 0xc0(%rsp)
               	leaq	0x80(%rsp), %r9
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
               	movups	%xmm0, -0x110(%rbp)
               	leaq	0xa0(%rsp), %r9
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
               	leaq	0xa0(%rsp), %r9
               	movups	-0x110(%rbp), %xmm14
               	pmullw	%xmm14, %xmm0
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	0xc0(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	movq	0x50(%rsp), %rdx
               	movq	0x58(%rsp), %rdi
               	leaq	-0x60(%rbp), %rsi
               	leaq	0x60(%rsp), %r8
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rdx, 0x70(%rsp)
               	movq	%rdi, 0x78(%rsp)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r8), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x80(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0xa0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
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
               	movups	%xmm0, -0x110(%rbp)
               	leaq	0xa0(%rsp), %r9
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
               	movups	-0x110(%rbp), %xmm15
               	pmuldq	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x80(%rsp), %r9
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
               	movups	%xmm0, -0x110(%rbp)
               	leaq	0xa0(%rsp), %r9
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
               	leaq	0xa0(%rsp), %r9
               	movups	-0x110(%rbp), %xmm15
               	pmuldq	%xmm0, %xmm15
               	movapd	%xmm15, %xmm0
               	movups	%xmm0, 0xa0(%rsp)
               	leaq	0x40(%rsp), %rdi
               	leaq	0x20(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movq	0x40(%rsp), %rax
               	movq	0x48(%rsp), %rcx
               	movq	0x50(%rsp), %rdx
               	movq	0x58(%rsp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x60(%rsp), %r8
               	movq	%rax, 0x60(%rsp)
               	movq	%rcx, 0x68(%rsp)
               	movq	%rdx, 0x70(%rsp)
               	movq	%rdi, 0x78(%rsp)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%r8), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r8), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	-0x130(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	leave
               	retq
               	movl	$0x2, %eax
               	jmp	<addr>

<check_extremes>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x38, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x240, %rsp            # imm = 0x240
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	0x40(%rsp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rbx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x40(%rsp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r12), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %rdx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdx)
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	movups	%xmm14, 0x80(%rax)
               	movups	%xmm14, 0x90(%rax)
               	movups	%xmm14, 0xa0(%rax)
               	movups	%xmm14, 0xb0(%rax)
               	movups	%xmm14, 0xc0(%rax)
               	movups	%xmm14, 0xd0(%rax)
               	movups	%xmm14, 0xe0(%rax)
               	movups	%xmm14, 0xf0(%rax)
               	movups	%xmm14, 0x100(%rax)
               	movups	%xmm14, 0x110(%rax)
               	movups	%xmm14, 0x120(%rax)
               	movups	%xmm14, 0x130(%rax)
               	movups	%xmm14, 0x140(%rax)
               	movups	%xmm14, 0x150(%rax)
               	movups	%xmm14, 0x160(%rax)
               	movups	%xmm14, 0x170(%rax)
               	leaq	0x1c0(%rsp), %r9
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x1e0(%rsp), %rax
               	movups	(%rdx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rdx), %xmm14
               	movups	%xmm14, 0x10(%rax)
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	movups	-0x30(%rbp), %xmm14
               	pminsb	%xmm14, %xmm0
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x1c0(%rsp), %r9
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	leaq	0x1e0(%rsp), %r9
               	movups	-0x30(%rbp), %xmm14
               	pminsb	%xmm14, %xmm0
               	movups	%xmm0, 0x1e0(%rsp)
               	leaq	0x200(%rsp), %rdi
               	leaq	0x220(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movq	0x200(%rsp), %rax
               	movq	0x208(%rsp), %rcx
               	movq	0x210(%rsp), %rdx
               	movq	0x218(%rsp), %rsi
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rdx, 0x50(%rsp)
               	movq	%rsi, 0x58(%rsp)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x1c0(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x1e0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	movups	-0x30(%rbp), %xmm14
               	pmaxsb	%xmm14, %xmm0
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x1c0(%rsp), %r9
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	leaq	0x1e0(%rsp), %r9
               	movups	-0x30(%rbp), %xmm14
               	pmaxsb	%xmm14, %xmm0
               	movups	%xmm0, 0x1e0(%rsp)
               	leaq	0x200(%rsp), %rdi
               	leaq	0x220(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movq	0x200(%rsp), %rcx
               	movq	0x208(%rsp), %rdx
               	movq	0x210(%rsp), %rsi
               	movq	0x218(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	addq	$0x20, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x1c0(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x1e0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	movups	-0x30(%rbp), %xmm14
               	pminsw	%xmm14, %xmm0
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x1c0(%rsp), %r9
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	leaq	0x1e0(%rsp), %r9
               	movups	-0x30(%rbp), %xmm14
               	pminsw	%xmm14, %xmm0
               	movups	%xmm0, 0x1e0(%rsp)
               	leaq	0x200(%rsp), %rdi
               	leaq	0x220(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movq	0x200(%rsp), %rcx
               	movq	0x208(%rsp), %rdx
               	movq	0x210(%rsp), %rsi
               	movq	0x218(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	addq	$0x40, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x1c0(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x1e0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	movups	-0x30(%rbp), %xmm14
               	pmaxsw	%xmm14, %xmm0
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x1c0(%rsp), %r9
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	leaq	0x1e0(%rsp), %r9
               	movups	-0x30(%rbp), %xmm14
               	pmaxsw	%xmm14, %xmm0
               	movups	%xmm0, 0x1e0(%rsp)
               	leaq	0x200(%rsp), %rdi
               	leaq	0x220(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movq	0x200(%rsp), %rcx
               	movq	0x208(%rsp), %rdx
               	movq	0x210(%rsp), %rsi
               	movq	0x218(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	addq	$0x60, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x1c0(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x1e0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	movups	-0x30(%rbp), %xmm14
               	pminsd	%xmm14, %xmm0
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x1c0(%rsp), %r9
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	leaq	0x1e0(%rsp), %r9
               	movups	-0x30(%rbp), %xmm14
               	pminsd	%xmm14, %xmm0
               	movups	%xmm0, 0x1e0(%rsp)
               	leaq	0x200(%rsp), %rdi
               	leaq	0x220(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movq	0x200(%rsp), %rcx
               	movq	0x208(%rsp), %rdx
               	movq	0x210(%rsp), %rsi
               	movq	0x218(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	addq	$0x80, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x1c0(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x1e0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	movups	-0x30(%rbp), %xmm14
               	pmaxsd	%xmm14, %xmm0
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x1c0(%rsp), %r9
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	leaq	0x1e0(%rsp), %r9
               	movups	-0x30(%rbp), %xmm14
               	pmaxsd	%xmm14, %xmm0
               	movups	%xmm0, 0x1e0(%rsp)
               	leaq	0x200(%rsp), %rdi
               	leaq	0x220(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movq	0x200(%rsp), %rcx
               	movq	0x208(%rsp), %rdx
               	movq	0x210(%rsp), %rsi
               	movq	0x218(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	addq	$0xa0, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x1c0(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x1e0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	movups	-0x30(%rbp), %xmm14
               	pminub	%xmm14, %xmm0
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x1c0(%rsp), %r9
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	leaq	0x1e0(%rsp), %r9
               	movups	-0x30(%rbp), %xmm14
               	pminub	%xmm14, %xmm0
               	movups	%xmm0, 0x1e0(%rsp)
               	leaq	0x200(%rsp), %rdi
               	leaq	0x220(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movq	0x200(%rsp), %rcx
               	movq	0x208(%rsp), %rdx
               	movq	0x210(%rsp), %rsi
               	movq	0x218(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	addq	$0xc0, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x1c0(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x1e0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	movups	-0x30(%rbp), %xmm14
               	pmaxub	%xmm14, %xmm0
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x1c0(%rsp), %r9
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	leaq	0x1e0(%rsp), %r9
               	movups	-0x30(%rbp), %xmm14
               	pmaxub	%xmm14, %xmm0
               	movups	%xmm0, 0x1e0(%rsp)
               	leaq	0x200(%rsp), %rdi
               	leaq	0x220(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movq	0x200(%rsp), %rcx
               	movq	0x208(%rsp), %rdx
               	movq	0x210(%rsp), %rsi
               	movq	0x218(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	addq	$0xe0, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x1c0(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x1e0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	movups	-0x30(%rbp), %xmm14
               	pminuw	%xmm14, %xmm0
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x1c0(%rsp), %r9
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	leaq	0x1e0(%rsp), %r9
               	movups	-0x30(%rbp), %xmm14
               	pminuw	%xmm14, %xmm0
               	movups	%xmm0, 0x1e0(%rsp)
               	leaq	0x200(%rsp), %rdi
               	leaq	0x220(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movq	0x200(%rsp), %rcx
               	movq	0x208(%rsp), %rdx
               	movq	0x210(%rsp), %rsi
               	movq	0x218(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	addq	$0x100, %rax            # imm = 0x100
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x1c0(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x1e0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	movups	-0x30(%rbp), %xmm14
               	pmaxuw	%xmm14, %xmm0
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x1c0(%rsp), %r9
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	leaq	0x1e0(%rsp), %r9
               	movups	-0x30(%rbp), %xmm14
               	pmaxuw	%xmm14, %xmm0
               	movups	%xmm0, 0x1e0(%rsp)
               	leaq	0x200(%rsp), %rdi
               	leaq	0x220(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movq	0x200(%rsp), %rcx
               	movq	0x208(%rsp), %rdx
               	movq	0x210(%rsp), %rsi
               	movq	0x218(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	addq	$0x120, %rax            # imm = 0x120
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x1c0(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x1e0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	movups	-0x30(%rbp), %xmm14
               	pminud	%xmm14, %xmm0
               	movups	%xmm0, 0x220(%rsp)
               	leaq	0x1c0(%rsp), %r9
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	leaq	0x1e0(%rsp), %r9
               	movups	-0x30(%rbp), %xmm14
               	pminud	%xmm14, %xmm0
               	movups	%xmm0, 0x1e0(%rsp)
               	leaq	0x200(%rsp), %rdi
               	leaq	0x220(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movq	0x200(%rsp), %rcx
               	movq	0x208(%rsp), %rdx
               	movq	0x210(%rsp), %rsi
               	movq	0x218(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	addq	$0x140, %rax            # imm = 0x140
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	leaq	(%rsp), %rax
               	leaq	0x20(%rsp), %rcx
               	leaq	0x1c0(%rsp), %r9
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%r9)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%r9)
               	leaq	0x1e0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	movups	-0x30(%rbp), %xmm14
               	pmaxud	%xmm14, %xmm0
               	movups	%xmm0, 0x20(%rsp)
               	leaq	0x1c0(%rsp), %r9
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
               	movups	%xmm0, -0x30(%rbp)
               	leaq	0x1e0(%rsp), %r9
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
               	leaq	0x1e0(%rsp), %r9
               	movups	-0x30(%rbp), %xmm14
               	pmaxud	%xmm14, %xmm0
               	movups	%xmm0, 0x1e0(%rsp)
               	leaq	0x200(%rsp), %rdi
               	leaq	0x20(%rsp), %rax
               	movq	%rax, %r10
               	movups	(%r10), %xmm0
               	movq	%r9, %r10
               	movups	(%r10), %xmm1
               	callq	<addr>
               	movq	0x200(%rsp), %rcx
               	movq	0x208(%rsp), %rdx
               	movq	0x210(%rsp), %rsi
               	movq	0x218(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	addq	$0x160, %rax            # imm = 0x160
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	xorl	%r15d, %r15d
               	movl	$0x1, %ecx
               	movq	%r15, %rax
               	shrq	%rax
               	imulq	$0x55555556, %rax, %rdx # imm = 0x55555556
               	shrq	$0x20, %rdx
               	leaq	(%rdx,%rdx,2), %rdx
               	subq	%rdx, %rax
               	shlxq	%rax, %rcx, %rcx
               	cmpl	$0x6, %r15d
               	setl	%r13b
               	movzbq	%r13b, %r13
               	movq	%r15, %r14
               	andq	$0x1, %r14
               	xorl	%r9d, %r9d
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r9d
               	jge	<addr>
               	xorl	%edx, %edx
               	leaq	-0x1(%rcx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rdx
               	movq	%rcx, %rsi
               	imulq	%r9, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testq	%r13, %r13
               	je	<addr>
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	decq	%rax
               	movslq	%eax, %rax
               	shrxq	%rax, %rdx, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shlxq	%rsi, %rax, %rax
               	orq	%rax, %rdx
               	xorl	%r8d, %r8d
               	leaq	-0x1(%rcx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %r8
               	movq	%rcx, %rsi
               	imulq	%r9, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movzbq	(%r12,%rsi), %rsi
               	orq	%rsi, %r8
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	testq	%r13, %r13
               	je	<addr>
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	decq	%rax
               	movslq	%eax, %rax
               	shrxq	%rax, %r8, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	%rcx, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shlxq	%rsi, %rax, %rax
               	orq	%rax, %r8
               	testq	%r13, %r13
               	je	<addr>
               	cmpq	%r8, %rdx
               	setl	%al
               	movzbq	%al, %rax
               	leaq	-0x20(%rbp), %rsi
               	testq	%r14, %r14
               	je	<addr>
               	testl	%eax, %eax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorl	%eax, %eax
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	imulq	%r9, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	movslq	%r8d, %r8
               	shrxq	%r8, %rdx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rsi,%rdi)
               	incq	%rax
               	cmpl	%ecx, %eax
               	jge	<addr>
               	jmp	<addr>
               	movq	%r8, %rdx
               	jmp	<addr>
               	cmpq	%r8, %rdx
               	setb	%al
               	movzbq	%al, %rax
               	jmp	<addr>
               	incq	%r9
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r9d
               	jl	<addr>
               	leaq	0x40(%rsp), %rax
               	movq	%r15, %rcx
               	shlq	$0x5, %rcx
               	leaq	(%rax,%rcx), %r9
               	leaq	-0x20(%rbp), %rdi
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
               	testl	%eax, %eax
               	je	<addr>
               	incq	%r15
               	cmpl	$0xc, %r15d
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x4, %eax
               	leaq	-0x60(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<check_abs_sign>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x88, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x120, %rsp            # imm = 0x120
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	0x60(%rsp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rbx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	0x60(%rsp), %rax
               	movq	0x68(%rsp), %rcx
               	movq	0x70(%rsp), %rdx
               	movq	0x78(%rsp), %rsi
               	leaq	0x60(%rsp), %rdi
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r12), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movq	0x60(%rsp), %r8
               	movq	0x68(%rsp), %r9
               	movq	0x70(%rsp), %r13
               	movq	0x78(%rsp), %r14
               	leaq	(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movups	%xmm14, 0x20(%rdi)
               	movups	%xmm14, 0x30(%rdi)
               	movups	%xmm14, 0x40(%rdi)
               	movups	%xmm14, 0x50(%rdi)
               	leaq	0xe0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xe0(%rsp)
               	movq	%rcx, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm0
               	pabsb	%xmm0, %xmm0
               	leaq	0xf0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rdx, 0xf0(%rsp)
               	movq	%rsi, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm1
               	pabsb	%xmm1, %xmm1
               	movups	%xmm0, 0x100(%rsp)
               	movups	%xmm1, 0xc0(%rsp)
               	movq	0x100(%rsp), %rdi
               	movq	0x108(%rsp), %r15
               	movq	0xc0(%rsp), %r10
               	movq	%r10, -0x68(%rbp)
               	movq	0xc8(%rsp), %r10
               	movq	%r10, -0x70(%rbp)
               	movq	%rdi, (%rsp)
               	movq	%r15, 0x8(%rsp)
               	movq	-0x68(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	-0x70(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0xe0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xe0(%rsp)
               	movq	%rcx, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm0
               	pabsw	%xmm0, %xmm0
               	leaq	0xf0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rdx, 0xf0(%rsp)
               	movq	%rsi, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm1
               	pabsw	%xmm1, %xmm1
               	movups	%xmm0, 0x100(%rsp)
               	movups	%xmm1, 0xc0(%rsp)
               	movq	0x100(%rsp), %r15
               	movq	0x108(%rsp), %r10
               	movq	%r10, -0x68(%rbp)
               	movq	0xc0(%rsp), %r10
               	movq	%r10, -0x70(%rbp)
               	movq	0xc8(%rsp), %r10
               	movq	%r10, -0x78(%rbp)
               	leaq	(%rsp), %rdi
               	addq	$0x20, %rdi
               	movq	%r15, (%rdi)
               	movq	-0x68(%rbp), %r11
               	movq	%r11, 0x8(%rdi)
               	movq	-0x70(%rbp), %r11
               	movq	%r11, 0x10(%rdi)
               	movq	-0x78(%rbp), %r11
               	movq	%r11, 0x18(%rdi)
               	leaq	0xe0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xe0(%rsp)
               	movq	%rcx, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm0
               	pabsd	%xmm0, %xmm0
               	leaq	0xf0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rdx, 0xf0(%rsp)
               	movq	%rsi, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm1
               	pabsd	%xmm1, %xmm1
               	movups	%xmm0, 0x100(%rsp)
               	movups	%xmm1, 0xc0(%rsp)
               	movq	0x100(%rsp), %r15
               	movq	0x108(%rsp), %r10
               	movq	%r10, -0x68(%rbp)
               	movq	0xc0(%rsp), %r10
               	movq	%r10, -0x70(%rbp)
               	movq	0xc8(%rsp), %r10
               	movq	%r10, -0x78(%rbp)
               	leaq	(%rsp), %rdi
               	addq	$0x40, %rdi
               	movq	%r15, (%rdi)
               	movq	-0x68(%rbp), %r11
               	movq	%r11, 0x8(%rdi)
               	movq	-0x70(%rbp), %r11
               	movq	%r11, 0x10(%rdi)
               	movq	-0x78(%rbp), %r11
               	movq	%r11, 0x18(%rdi)
               	leaq	0x60(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movups	%xmm14, 0x10(%rdi)
               	movups	%xmm14, 0x20(%rdi)
               	movups	%xmm14, 0x30(%rdi)
               	movups	%xmm14, 0x40(%rdi)
               	movups	%xmm14, 0x50(%rdi)
               	leaq	0xe0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xe0(%rsp)
               	movq	%rcx, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm0
               	leaq	0xe0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%r8, 0xe0(%rsp)
               	movq	%r9, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm1
               	psignb	%xmm1, %xmm0
               	leaq	0xf0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rdx, 0xf0(%rsp)
               	movq	%rsi, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm1
               	leaq	0xf0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%r13, 0xf0(%rsp)
               	movq	%r14, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm2
               	psignb	%xmm2, %xmm1
               	movups	%xmm0, 0x100(%rsp)
               	movups	%xmm1, 0xc0(%rsp)
               	movq	0x100(%rsp), %rdi
               	movq	0x108(%rsp), %r15
               	movq	0xc0(%rsp), %r10
               	movq	%r10, -0x68(%rbp)
               	movq	0xc8(%rsp), %r10
               	movq	%r10, -0x70(%rbp)
               	movq	%rdi, 0x60(%rsp)
               	movq	%r15, 0x68(%rsp)
               	movq	-0x68(%rbp), %r10
               	movq	%r10, 0x70(%rsp)
               	movq	-0x70(%rbp), %r10
               	movq	%r10, 0x78(%rsp)
               	leaq	0xe0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xe0(%rsp)
               	movq	%rcx, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm0
               	leaq	0xe0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%r8, 0xe0(%rsp)
               	movq	%r9, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm1
               	psignw	%xmm1, %xmm0
               	leaq	0xf0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rdx, 0xf0(%rsp)
               	movq	%rsi, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm1
               	leaq	0xf0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%r13, 0xf0(%rsp)
               	movq	%r14, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm2
               	psignw	%xmm2, %xmm1
               	movups	%xmm0, 0x100(%rsp)
               	movups	%xmm1, 0xc0(%rsp)
               	movq	0x100(%rsp), %r15
               	movq	0x108(%rsp), %r10
               	movq	%r10, -0x68(%rbp)
               	movq	0xc0(%rsp), %r10
               	movq	%r10, -0x70(%rbp)
               	movq	0xc8(%rsp), %r10
               	movq	%r10, -0x78(%rbp)
               	leaq	0x60(%rsp), %rdi
               	addq	$0x20, %rdi
               	movq	%r15, (%rdi)
               	movq	-0x68(%rbp), %r11
               	movq	%r11, 0x8(%rdi)
               	movq	-0x70(%rbp), %r11
               	movq	%r11, 0x10(%rdi)
               	movq	-0x78(%rbp), %r11
               	movq	%r11, 0x18(%rdi)
               	leaq	0xe0(%rsp), %rdi
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rdi)
               	movq	%rax, 0xe0(%rsp)
               	movq	%rcx, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm0
               	leaq	0xe0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r8, 0xe0(%rsp)
               	movq	%r9, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm1
               	psignd	%xmm1, %xmm0
               	leaq	0xf0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xf0(%rsp)
               	leaq	0xf0(%rsp), %rax
               	movq	%rsi, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm1
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r13, 0xf0(%rsp)
               	movq	%r14, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm2
               	psignd	%xmm2, %xmm1
               	movups	%xmm0, 0x100(%rsp)
               	movups	%xmm1, 0xc0(%rsp)
               	movq	0x100(%rsp), %rcx
               	movq	0x108(%rsp), %rdx
               	movq	0xc0(%rsp), %rsi
               	movq	0xc8(%rsp), %rdi
               	leaq	0x60(%rsp), %rax
               	addq	$0x40, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	xorl	%r15d, %r15d
               	movl	$0x1, %eax
               	shlxq	%r15, %rax, %rcx
               	xorl	%r8d, %r8d
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r8d
               	jge	<addr>
               	xorl	%edx, %edx
               	leaq	-0x1(%rcx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rdx
               	movq	%rcx, %rsi
               	imulq	%r8, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movzbq	(%rbx,%rsi), %rsi
               	orq	%rsi, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rsi
               	movslq	%esi, %rsi
               	shrxq	%rsi, %rdx, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movq	$-0x1, %rsi
               	movslq	%eax, %rax
               	shlxq	%rax, %rsi, %rax
               	orq	%rax, %rdx
               	xorl	%r9d, %r9d
               	leaq	-0x1(%rcx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %r9
               	movq	%rcx, %rsi
               	imulq	%r8, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movzbq	(%r12,%rsi), %rsi
               	orq	%rsi, %r9
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rsi
               	movslq	%esi, %rsi
               	shrxq	%rsi, %r9, %rsi
               	testb	$0x1, %sil
               	je	<addr>
               	movq	$-0x1, %rsi
               	movslq	%eax, %rax
               	shlxq	%rax, %rsi, %rax
               	orq	%rax, %r9
               	leaq	-0x60(%rbp), %rdi
               	testq	%rdx, %rdx
               	jge	<addr>
               	movq	%rdx, %rsi
               	negq	%rsi
               	xorl	%eax, %eax
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %r13
               	imulq	%r8, %r13
               	addq	%rax, %r13
               	movslq	%r13d, %r13
               	movq	%rax, %r14
               	shlq	$0x3, %r14
               	movslq	%r14d, %r14
               	shrxq	%r14, %rsi, %r14
               	andq	$0xff, %r14
               	movb	%r14b, (%rdi,%r13)
               	incq	%rax
               	cmpl	%ecx, %eax
               	jl	<addr>
               	leaq	-0x40(%rbp), %rsi
               	testq	%r9, %r9
               	jge	<addr>
               	negq	%rdx
               	xorl	%eax, %eax
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	imulq	%r8, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r9
               	shlq	$0x3, %r9
               	movslq	%r9d, %r9
               	shrxq	%r9, %rdx, %r9
               	andq	$0xff, %r9
               	movb	%r9b, (%rsi,%rdi)
               	incq	%rax
               	cmpl	%ecx, %eax
               	jge	<addr>
               	jmp	<addr>
               	testq	%r9, %r9
               	jne	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	movq	%rdx, %rsi
               	jmp	<addr>
               	incq	%r8
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r8d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	%r15, %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	-0x60(%rbp), %rsi
               	leaq	0xc0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0x60(%rsp), %rax
               	movq	%r15, %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0xc0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r15
               	cmpl	$0x3, %r15d
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
               	movl	$0x8, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<model_horizontal>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x28, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	movq	%rdi, 0x48(%rsp)
               	movslq	%r8d, %r8
               	movslq	%ecx, %r11
               	movq	%r11, 0x38(%rsp)
               	movq	%rdx, %rbx
               	movq	%rsi, 0x40(%rsp)
               	movl	$0x8, %eax
               	cltd
               	idivl	%ebx
               	movq	%rax, %r14
               	xorl	%r15d, %r15d
               	xorl	%r13d, %r13d
               	movq	%r14, %rax
               	shlq	%rax
               	cmpl	%eax, %r13d
               	jge	<addr>
               	cmpl	%r14d, %r13d
               	jge	<addr>
               	movq	0x48(%rsp), %rdi
               	movq	%r15, %rax
               	shlq	$0x4, %rax
               	leaq	(%rdi,%rax), %r12
               	movl	%r13d, %eax
               	cltd
               	idivl	%r14d
               	movq	%rdx, %rcx
               	shlq	%rcx
               	xorl	%eax, %eax
               	leaq	-0x1(%rbx), %rdx
               	testl	%edx, %edx
               	jl	<addr>
               	shlq	$0x8, %rax
               	movq	%rbx, %rsi
               	imulq	%rcx, %rsi
               	addq	%rdx, %rsi
               	movslq	%esi, %rsi
               	movzbq	(%r12,%rsi), %rsi
               	orq	%rsi, %rax
               	decq	%rdx
               	testl	%edx, %edx
               	jge	<addr>
               	cmpl	$0x8, %ebx
               	jge	<addr>
               	movq	%rbx, %rdx
               	shlq	$0x3, %rdx
               	decq	%rdx
               	movslq	%edx, %rdx
               	shrxq	%rdx, %rax, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movq	$-0x1, %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shlxq	%rsi, %rdx, %rdx
               	orq	%rdx, %rax
               	leaq	0x1(%rcx), %rsi
               	xorl	%ecx, %ecx
               	leaq	-0x1(%rbx), %rdx
               	testl	%edx, %edx
               	jl	<addr>
               	shlq	$0x8, %rcx
               	movq	%rbx, %rdi
               	imulq	%rsi, %rdi
               	addq	%rdx, %rdi
               	movslq	%edi, %rdi
               	movzbq	(%r12,%rdi), %rdi
               	orq	%rdi, %rcx
               	decq	%rdx
               	testl	%edx, %edx
               	jge	<addr>
               	cmpl	$0x8, %ebx
               	jge	<addr>
               	movq	%rbx, %rdx
               	shlq	$0x3, %rdx
               	decq	%rdx
               	movslq	%edx, %rdx
               	shrxq	%rdx, %rcx, %rdx
               	testb	$0x1, %dl
               	je	<addr>
               	movq	$-0x1, %rdx
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	shlxq	%rsi, %rdx, %rdx
               	orq	%rdx, %rcx
               	movq	0x38(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	movq	%r15, %rax
               	shlq	$0x4, %rax
               	leaq	(%r9,%rax), %rcx
               	testq	%r8, %r8
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	decq	%rsi
               	movslq	%esi, %rsi
               	shlxq	%rsi, %rax, %rax
               	negq	%rax
               	movl	$0x1, %esi
               	movq	%rbx, %rdi
               	shlq	$0x3, %rdi
               	decq	%rdi
               	movslq	%edi, %rdi
               	shlxq	%rdi, %rsi, %rsi
               	decq	%rsi
               	cmpq	%rax, %rdx
               	jge	<addr>
               	movq	%rax, %rdx
               	xorl	%eax, %eax
               	cmpl	%ebx, %eax
               	jge	<addr>
               	movq	%rbx, %rsi
               	imulq	%r13, %rsi
               	addq	%rax, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %rdx, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rcx,%rsi)
               	incq	%rax
               	cmpl	%ebx, %eax
               	jge	<addr>
               	jmp	<addr>
               	cmpq	%rsi, %rdx
               	jle	<addr>
               	movq	%rsi, %rdx
               	jmp	<addr>
               	leaq	(%rax,%rcx), %rdx
               	jmp	<addr>
               	movq	0x40(%rsp), %rdi
               	jmp	<addr>
               	incq	%r13
               	movq	%r14, %rax
               	shlq	%rax
               	cmpl	%eax, %r13d
               	jl	<addr>
               	incq	%r15
               	cmpl	$0x2, %r15d
               	jl	<addr>
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<check_horizontal>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x120, %rsp            # imm = 0x120
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	(%rsp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rbx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	(%rsp), %rdi
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r12), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movq	(%rsp), %rdi
               	movq	0x8(%rsp), %r8
               	movq	0x10(%rsp), %r9
               	movq	0x18(%rsp), %r13
               	leaq	(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movups	%xmm14, 0x10(%r14)
               	movups	%xmm14, 0x20(%r14)
               	movups	%xmm14, 0x30(%r14)
               	movups	%xmm14, 0x40(%r14)
               	movups	%xmm14, 0x50(%r14)
               	movups	%xmm14, 0x60(%r14)
               	movups	%xmm14, 0x70(%r14)
               	movups	%xmm14, 0x80(%r14)
               	movups	%xmm14, 0x90(%r14)
               	movups	%xmm14, 0xa0(%r14)
               	movups	%xmm14, 0xb0(%r14)
               	leaq	0xe0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rax, 0xe0(%rsp)
               	movq	%rcx, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm0
               	leaq	0xe0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdi, 0xe0(%rsp)
               	movq	%r8, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm1
               	phaddw	%xmm1, %xmm0
               	leaq	0xf0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdx, 0xf0(%rsp)
               	movq	%rsi, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm1
               	leaq	0xf0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%r9, 0xf0(%rsp)
               	movq	%r13, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm2
               	phaddw	%xmm2, %xmm1
               	movups	%xmm0, 0x100(%rsp)
               	movups	%xmm1, 0xc0(%rsp)
               	movq	0x100(%rsp), %r14
               	movq	0x108(%rsp), %r15
               	movq	0xc0(%rsp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0xc8(%rsp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	%r14, (%rsp)
               	movq	%r15, 0x8(%rsp)
               	movq	-0x48(%rbp), %r10
               	movq	%r10, 0x10(%rsp)
               	movq	-0x50(%rbp), %r10
               	movq	%r10, 0x18(%rsp)
               	leaq	0xe0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rax, 0xe0(%rsp)
               	movq	%rcx, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm0
               	leaq	0xe0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdi, 0xe0(%rsp)
               	movq	%r8, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm1
               	phaddd	%xmm1, %xmm0
               	leaq	0xf0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdx, 0xf0(%rsp)
               	movq	%rsi, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm1
               	leaq	0xf0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%r9, 0xf0(%rsp)
               	movq	%r13, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm2
               	phaddd	%xmm2, %xmm1
               	movups	%xmm0, 0x100(%rsp)
               	movups	%xmm1, 0xc0(%rsp)
               	movq	0x100(%rsp), %r15
               	movq	0x108(%rsp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0xc0(%rsp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	0xc8(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	leaq	(%rsp), %r14
               	addq	$0x20, %r14
               	movq	%r15, (%r14)
               	movq	-0x48(%rbp), %r11
               	movq	%r11, 0x8(%r14)
               	movq	-0x50(%rbp), %r11
               	movq	%r11, 0x10(%r14)
               	movq	-0x58(%rbp), %r11
               	movq	%r11, 0x18(%r14)
               	leaq	0xe0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rax, 0xe0(%rsp)
               	movq	%rcx, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm0
               	leaq	0xe0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdi, 0xe0(%rsp)
               	movq	%r8, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm1
               	phsubw	%xmm1, %xmm0
               	leaq	0xf0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdx, 0xf0(%rsp)
               	movq	%rsi, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm1
               	leaq	0xf0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%r9, 0xf0(%rsp)
               	movq	%r13, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm2
               	phsubw	%xmm2, %xmm1
               	movups	%xmm0, 0x100(%rsp)
               	movups	%xmm1, 0xc0(%rsp)
               	movq	0x100(%rsp), %r15
               	movq	0x108(%rsp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0xc0(%rsp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	0xc8(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	leaq	(%rsp), %r14
               	addq	$0x40, %r14
               	movq	%r15, (%r14)
               	movq	-0x48(%rbp), %r11
               	movq	%r11, 0x8(%r14)
               	movq	-0x50(%rbp), %r11
               	movq	%r11, 0x10(%r14)
               	movq	-0x58(%rbp), %r11
               	movq	%r11, 0x18(%r14)
               	leaq	0xe0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rax, 0xe0(%rsp)
               	movq	%rcx, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm0
               	leaq	0xe0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdi, 0xe0(%rsp)
               	movq	%r8, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm1
               	phsubd	%xmm1, %xmm0
               	leaq	0xf0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdx, 0xf0(%rsp)
               	movq	%rsi, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm1
               	leaq	0xf0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%r9, 0xf0(%rsp)
               	movq	%r13, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm2
               	phsubd	%xmm2, %xmm1
               	movups	%xmm0, 0x100(%rsp)
               	movups	%xmm1, 0xc0(%rsp)
               	movq	0x100(%rsp), %r15
               	movq	0x108(%rsp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0xc0(%rsp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	0xc8(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	leaq	(%rsp), %r14
               	addq	$0x60, %r14
               	movq	%r15, (%r14)
               	movq	-0x48(%rbp), %r11
               	movq	%r11, 0x8(%r14)
               	movq	-0x50(%rbp), %r11
               	movq	%r11, 0x10(%r14)
               	movq	-0x58(%rbp), %r11
               	movq	%r11, 0x18(%r14)
               	leaq	0xe0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rax, 0xe0(%rsp)
               	movq	%rcx, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm0
               	leaq	0xe0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdi, 0xe0(%rsp)
               	movq	%r8, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm1
               	phaddsw	%xmm1, %xmm0
               	leaq	0xf0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rdx, 0xf0(%rsp)
               	movq	%rsi, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm1
               	leaq	0xf0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%r9, 0xf0(%rsp)
               	movq	%r13, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm2
               	phaddsw	%xmm2, %xmm1
               	movups	%xmm0, 0x100(%rsp)
               	movups	%xmm1, 0xc0(%rsp)
               	movq	0x100(%rsp), %r15
               	movq	0x108(%rsp), %r10
               	movq	%r10, -0x48(%rbp)
               	movq	0xc0(%rsp), %r10
               	movq	%r10, -0x50(%rbp)
               	movq	0xc8(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	leaq	(%rsp), %r14
               	addq	$0x80, %r14
               	movq	%r15, (%r14)
               	movq	-0x48(%rbp), %r11
               	movq	%r11, 0x8(%r14)
               	movq	-0x50(%rbp), %r11
               	movq	%r11, 0x10(%r14)
               	movq	-0x58(%rbp), %r11
               	movq	%r11, 0x18(%r14)
               	leaq	0xe0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rax, 0xe0(%rsp)
               	movq	%rcx, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm0
               	leaq	0xe0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdi, 0xe0(%rsp)
               	movq	%r8, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm1
               	phsubsw	%xmm1, %xmm0
               	leaq	0xf0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xf0(%rsp)
               	leaq	0xf0(%rsp), %rax
               	movq	%rsi, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm1
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r9, 0xf0(%rsp)
               	movq	%r13, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm2
               	phsubsw	%xmm2, %xmm1
               	movups	%xmm0, 0x100(%rsp)
               	movups	%xmm1, 0xc0(%rsp)
               	movq	0x100(%rsp), %rcx
               	movq	0x108(%rsp), %rdx
               	movq	0xc0(%rsp), %rsi
               	movq	0xc8(%rsp), %rdi
               	leaq	(%rsp), %rax
               	addq	$0xa0, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	leaq	-0x40(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%rcx, %r8
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	(%rsp), %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0xc0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x4, %edx
               	xorl	%ecx, %ecx
               	leaq	-0x40(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%rcx, %r8
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x20(%rax), %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0xc0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %edx
               	movl	$0x1, %ecx
               	xorl	%r8d, %r8d
               	leaq	-0x40(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x40(%rax), %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0xc0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %edx
               	movl	$0x1, %ecx
               	xorl	%r8d, %r8d
               	leaq	-0x40(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x60(%rax), %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0xc0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %edx
               	xorl	%ecx, %ecx
               	movl	$0x1, %r8d
               	leaq	-0x40(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	leaq	0x80(%rax), %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0xc0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %edx
               	movl	$0x1, %ecx
               	leaq	-0x40(%rbp), %r9
               	movq	%rbx, %rdi
               	movq	%rcx, %r8
               	movq	%r12, %rsi
               	callq	<addr>
               	leaq	(%rsp), %rax
               	leaq	0xa0(%rax), %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0xc0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	xorl	%eax, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<check_compares>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x88, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x120, %rsp            # imm = 0x120
               	andq	$-0x20, %rsp
               	movq	%rdi, %rbx
               	movq	%rsi, %r12
               	leaq	0x40(%rsp), %rax
               	movups	(%rbx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rbx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x40(%rsp), %rax
               	movups	(%r12), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r12), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	0x20(%rsp), %rcx
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rcx)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rcx)
               	leaq	0x40(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movups	%xmm14, 0x10(%rax)
               	movups	%xmm14, 0x20(%rax)
               	movups	%xmm14, 0x30(%rax)
               	movups	%xmm14, 0x40(%rax)
               	movups	%xmm14, 0x50(%rax)
               	movups	%xmm14, 0x60(%rax)
               	movups	%xmm14, 0x70(%rax)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %r13
               	leaq	0xe0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rax, 0xe0(%rsp)
               	movq	%rcx, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm0
               	leaq	0xe0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdi, 0xe0(%rsp)
               	movq	%r8, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm1
               	pcmpgtb	%xmm1, %xmm0
               	leaq	0xf0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xf0(%rsp)
               	leaq	0xf0(%rsp), %rax
               	movq	%rsi, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm1
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r9, 0xf0(%rsp)
               	movq	%r13, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm2
               	pcmpgtb	%xmm2, %xmm1
               	movups	%xmm0, 0x100(%rsp)
               	movups	%xmm1, 0xc0(%rsp)
               	movq	0x100(%rsp), %rax
               	movq	0x108(%rsp), %rcx
               	movq	0xc0(%rsp), %rdx
               	movq	0xc8(%rsp), %rsi
               	movq	%rax, 0x40(%rsp)
               	movq	%rcx, 0x48(%rsp)
               	movq	%rdx, 0x50(%rsp)
               	movq	%rsi, 0x58(%rsp)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %r13
               	leaq	0xe0(%rsp), %r14
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r14)
               	movq	%rax, 0xe0(%rsp)
               	movq	%rcx, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm0
               	leaq	0xe0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdi, 0xe0(%rsp)
               	movq	%r8, 0xe8(%rsp)
               	movups	0xe0(%rsp), %xmm1
               	pcmpgtw	%xmm1, %xmm0
               	leaq	0xf0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xf0(%rsp)
               	leaq	0xf0(%rsp), %rax
               	movq	%rsi, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm1
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r9, 0xf0(%rsp)
               	movq	%r13, 0xf8(%rsp)
               	movups	0xf0(%rsp), %xmm2
               	pcmpgtw	%xmm2, %xmm1
               	movups	%xmm0, 0x100(%rsp)
               	movups	%xmm1, 0xc0(%rsp)
               	movq	0x100(%rsp), %rcx
               	movq	0x108(%rsp), %rdx
               	movq	0xc0(%rsp), %rsi
               	movq	0xc8(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	addq	$0x20, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	movl	(%rsp), %eax
               	movl	0x4(%rsp), %ecx
               	movl	0x8(%rsp), %edx
               	movl	0xc(%rsp), %esi
               	movl	0x10(%rsp), %edi
               	movl	0x14(%rsp), %r8d
               	movl	0x18(%rsp), %r9d
               	movl	0x1c(%rsp), %r13d
               	movl	0x20(%rsp), %r14d
               	movl	0x24(%rsp), %r15d
               	movl	0x28(%rsp), %r10d
               	movq	%r10, -0x48(%rbp)
               	movl	0x2c(%rsp), %r10d
               	movq	%r10, -0x50(%rbp)
               	movl	0x30(%rsp), %r10d
               	movq	%r10, -0x58(%rbp)
               	movl	0x34(%rsp), %r10d
               	movq	%r10, -0x60(%rbp)
               	movl	0x38(%rsp), %r10d
               	movq	%r10, -0x68(%rbp)
               	movl	0x3c(%rsp), %r10d
               	movq	%r10, -0x70(%rbp)
               	cmpl	%r14d, %eax
               	setg	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0xc0(%rsp)
               	cmpl	%r15d, %ecx
               	setg	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0xc4(%rsp)
               	cmpl	-0x48(%rbp), %edx
               	setg	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0xc8(%rsp)
               	cmpl	-0x50(%rbp), %esi
               	setg	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0xcc(%rsp)
               	cmpl	-0x58(%rbp), %edi
               	setg	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0xd0(%rsp)
               	cmpl	-0x60(%rbp), %r8d
               	setg	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0xd4(%rsp)
               	cmpl	-0x68(%rbp), %r9d
               	setg	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0xd8(%rsp)
               	cmpl	-0x70(%rbp), %r13d
               	setg	%al
               	movzbq	%al, %rax
               	negq	%rax
               	movl	%eax, 0xdc(%rsp)
               	movq	0xc0(%rsp), %rcx
               	movq	0xc8(%rsp), %rdx
               	movq	0xd0(%rsp), %rsi
               	movq	0xd8(%rsp), %rdi
               	leaq	0x40(%rsp), %rax
               	addq	$0x40, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	movq	0x20(%rsp), %rdi
               	movq	0x28(%rsp), %r8
               	movq	0x30(%rsp), %r9
               	movq	0x38(%rsp), %r13
               	cmpq	%rdi, %rax
               	setg	%al
               	movzbq	%al, %rax
               	movq	%rax, %rdi
               	negq	%rdi
               	cmpq	%r8, %rcx
               	setg	%al
               	movzbq	%al, %rax
               	movq	%rax, %rcx
               	negq	%rcx
               	cmpq	%r9, %rdx
               	setg	%al
               	movzbq	%al, %rax
               	movq	%rax, %rdx
               	negq	%rdx
               	cmpq	%r13, %rsi
               	setg	%al
               	movzbq	%al, %rax
               	movq	%rax, %rsi
               	negq	%rsi
               	leaq	0x40(%rsp), %rax
               	addq	$0x60, %rax
               	movq	%rdi, (%rax)
               	movq	%rcx, 0x8(%rax)
               	movq	%rdx, 0x10(%rax)
               	movq	%rsi, 0x18(%rax)
               	xorl	%r13d, %r13d
               	movl	$0x1, %eax
               	shlxq	%r13, %rax, %rcx
               	xorl	%r9d, %r9d
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r9d
               	jge	<addr>
               	leaq	-0x40(%rbp), %rsi
               	xorl	%edx, %edx
               	leaq	-0x1(%rcx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %rdx
               	movq	%rcx, %rdi
               	imulq	%r9, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movzbq	(%rbx,%rdi), %rdi
               	orq	%rdi, %rdx
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	leaq	-0x1(%rax), %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %rdx, %rdi
               	testb	$0x1, %dil
               	je	<addr>
               	movq	$-0x1, %rdi
               	movslq	%eax, %rax
               	shlxq	%rax, %rdi, %rax
               	orq	%rax, %rdx
               	xorl	%r8d, %r8d
               	leaq	-0x1(%rcx), %rax
               	testl	%eax, %eax
               	jl	<addr>
               	shlq	$0x8, %r8
               	movq	%rcx, %rdi
               	imulq	%r9, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movzbq	(%r12,%rdi), %rdi
               	orq	%rdi, %r8
               	decq	%rax
               	testl	%eax, %eax
               	jge	<addr>
               	cmpl	$0x8, %ecx
               	jge	<addr>
               	movq	%rcx, %rax
               	shlq	$0x3, %rax
               	decq	%rax
               	movslq	%eax, %rax
               	shrxq	%rax, %r8, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	%rcx, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shlxq	%rdi, %rax, %rax
               	orq	%rax, %r8
               	cmpq	%r8, %rdx
               	jle	<addr>
               	movq	$-0x1, %rdx
               	xorl	%eax, %eax
               	cmpl	%ecx, %eax
               	jge	<addr>
               	movq	%rcx, %rdi
               	imulq	%r9, %rdi
               	addq	%rax, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r8
               	shlq	$0x3, %r8
               	movslq	%r8d, %r8
               	shrxq	%r8, %rdx, %r8
               	andq	$0xff, %r8
               	movb	%r8b, (%rsi,%rdi)
               	incq	%rax
               	cmpl	%ecx, %eax
               	jge	<addr>
               	jmp	<addr>
               	xorl	%edx, %edx
               	jmp	<addr>
               	incq	%r9
               	movl	$0x20, %eax
               	cltd
               	idivl	%ecx
               	cmpl	%eax, %r9d
               	jl	<addr>
               	leaq	0x40(%rsp), %rax
               	movq	%r13, %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0xc0(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	incq	%r13
               	cmpl	$0x4, %r13d
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
               	movl	$0x20, %eax
               	leaq	-0xb0(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<check_packs>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xe0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x48(%rbp)
               	movq	%rsi, -0x50(%rbp)
               	leaq	(%rsp), %rax
               	movq	-0x48(%rbp), %r10
               	movups	(%r10), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r10), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	(%rsp), %rdi
               	movq	-0x50(%rbp), %r10
               	movups	(%r10), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r10), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movq	(%rsp), %rdi
               	movq	0x8(%rsp), %r8
               	movq	0x10(%rsp), %r9
               	movq	0x18(%rsp), %rbx
               	leaq	(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movups	%xmm14, 0x10(%r12)
               	movups	%xmm14, 0x20(%r12)
               	movups	%xmm14, 0x30(%r12)
               	movups	%xmm14, 0x40(%r12)
               	movups	%xmm14, 0x50(%r12)
               	movups	%xmm14, 0x60(%r12)
               	movups	%xmm14, 0x70(%r12)
               	leaq	0xa0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rax, 0xa0(%rsp)
               	movq	%rcx, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rdi, 0xa0(%rsp)
               	movq	%r8, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm1
               	packsswb	%xmm1, %xmm0
               	leaq	0xb0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rdx, 0xb0(%rsp)
               	movq	%rsi, 0xb8(%rsp)
               	movups	0xb0(%rsp), %xmm1
               	leaq	0xb0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%r9, 0xb0(%rsp)
               	movq	%rbx, 0xb8(%rsp)
               	movups	0xb0(%rsp), %xmm2
               	packsswb	%xmm2, %xmm1
               	movups	%xmm0, 0xc0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	movq	0xc0(%rsp), %r12
               	movq	0xc8(%rsp), %r13
               	movq	0x80(%rsp), %r14
               	movq	0x88(%rsp), %r15
               	movq	%r12, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xa0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rax, 0xa0(%rsp)
               	movq	%rcx, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rdi, 0xa0(%rsp)
               	movq	%r8, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm1
               	packssdw	%xmm1, %xmm0
               	leaq	0xb0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rdx, 0xb0(%rsp)
               	movq	%rsi, 0xb8(%rsp)
               	movups	0xb0(%rsp), %xmm1
               	leaq	0xb0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%r9, 0xb0(%rsp)
               	movq	%rbx, 0xb8(%rsp)
               	movups	0xb0(%rsp), %xmm2
               	packssdw	%xmm2, %xmm1
               	movups	%xmm0, 0xc0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	movq	0xc0(%rsp), %r13
               	movq	0xc8(%rsp), %r14
               	movq	0x80(%rsp), %r15
               	movq	0x88(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	leaq	(%rsp), %r12
               	addq	$0x20, %r12
               	movq	%r13, (%r12)
               	movq	%r14, 0x8(%r12)
               	movq	%r15, 0x10(%r12)
               	movq	-0x58(%rbp), %r11
               	movq	%r11, 0x18(%r12)
               	leaq	0xa0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rax, 0xa0(%rsp)
               	movq	%rcx, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rdi, 0xa0(%rsp)
               	movq	%r8, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm1
               	packuswb	%xmm1, %xmm0
               	leaq	0xb0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rdx, 0xb0(%rsp)
               	movq	%rsi, 0xb8(%rsp)
               	movups	0xb0(%rsp), %xmm1
               	leaq	0xb0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%r9, 0xb0(%rsp)
               	movq	%rbx, 0xb8(%rsp)
               	movups	0xb0(%rsp), %xmm2
               	packuswb	%xmm2, %xmm1
               	movups	%xmm0, 0xc0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	movq	0xc0(%rsp), %r13
               	movq	0xc8(%rsp), %r14
               	movq	0x80(%rsp), %r15
               	movq	0x88(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	leaq	(%rsp), %r12
               	addq	$0x40, %r12
               	movq	%r13, (%r12)
               	movq	%r14, 0x8(%r12)
               	movq	%r15, 0x10(%r12)
               	movq	-0x58(%rbp), %r11
               	movq	%r11, 0x18(%r12)
               	leaq	0xa0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rax, 0xa0(%rsp)
               	movq	%rcx, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdi, 0xa0(%rsp)
               	movq	%r8, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm1
               	packusdw	%xmm1, %xmm0
               	leaq	0xb0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xb0(%rsp)
               	leaq	0xb0(%rsp), %rax
               	movq	%rsi, 0xb8(%rsp)
               	movups	0xb0(%rsp), %xmm1
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r9, 0xb0(%rsp)
               	movq	%rbx, 0xb8(%rsp)
               	movups	0xb0(%rsp), %xmm2
               	packusdw	%xmm2, %xmm1
               	movups	%xmm0, 0xc0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	movq	0xc0(%rsp), %rcx
               	movq	0xc8(%rsp), %rdx
               	movq	0x80(%rsp), %rsi
               	movq	0x88(%rsp), %rdi
               	leaq	(%rsp), %rax
               	addq	$0x60, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	xorl	%r10d, %r10d
               	movq	%r10, -0x58(%rbp)
               	movq	-0x58(%rbp), %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	testb	$0x1, %al
               	je	<addr>
               	movl	$0x4, %ebx
               	movq	-0x58(%rbp), %r15
               	cmpl	$0x2, %r15d
               	setl	%r15b
               	movzbq	%r15b, %r15
               	movl	$0x10, %eax
               	cltd
               	idivl	%ebx
               	movq	%rax, %r13
               	xorl	%r14d, %r14d
               	xorl	%r9d, %r9d
               	movq	%r13, %rax
               	shlq	%rax
               	cmpl	%eax, %r9d
               	jge	<addr>
               	cmpl	%r13d, %r9d
               	jge	<addr>
               	movq	-0x48(%rbp), %rdi
               	movq	%r14, %rax
               	shlq	$0x4, %rax
               	leaq	(%rdi,%rax), %r12
               	movl	%r9d, %eax
               	cltd
               	idivl	%r13d
               	xorl	%r8d, %r8d
               	leaq	-0x1(%rbx), %rcx
               	testl	%ecx, %ecx
               	jl	<addr>
               	shlq	$0x8, %r8
               	movq	%rbx, %rax
               	imulq	%rdx, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movzbq	(%r12,%rax), %rax
               	orq	%rax, %r8
               	decq	%rcx
               	testl	%ecx, %ecx
               	jge	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	decq	%rax
               	shrxq	%rax, %r8, %rax
               	testb	$0x1, %al
               	je	<addr>
               	movq	$-0x1, %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	shlxq	%rcx, %rax, %rax
               	orq	%rax, %r8
               	leaq	-0x40(%rbp), %rax
               	movq	%r14, %rcx
               	shlq	$0x4, %rcx
               	leaq	(%rax,%rcx), %rsi
               	movq	%rbx, %rdx
               	shrq	%rdx
               	testq	%r15, %r15
               	je	<addr>
               	movl	$0x1, %eax
               	movq	%rdx, %rcx
               	shlq	$0x3, %rcx
               	decq	%rcx
               	shlxq	%rcx, %rax, %rax
               	negq	%rax
               	testq	%r15, %r15
               	je	<addr>
               	movl	$0x1, %ecx
               	movq	%rdx, %rdi
               	shlq	$0x3, %rdi
               	decq	%rdi
               	shlxq	%rdi, %rcx, %rcx
               	decq	%rcx
               	cmpq	%rax, %r8
               	jge	<addr>
               	xorl	%ecx, %ecx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	movq	%rdx, %r8
               	imulq	%r9, %r8
               	addq	%rcx, %r8
               	movslq	%r8d, %r8
               	movq	%rcx, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %rax, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%rsi,%r8)
               	incq	%rcx
               	cmpl	%edx, %ecx
               	jge	<addr>
               	jmp	<addr>
               	cmpq	%rcx, %r8
               	jle	<addr>
               	movq	%rcx, %rax
               	jmp	<addr>
               	movq	%r8, %rax
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rdx, %rdi
               	shlq	$0x3, %rdi
               	shlxq	%rdi, %rcx, %rcx
               	decq	%rcx
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movq	-0x50(%rbp), %rdi
               	jmp	<addr>
               	incq	%r9
               	movq	%r13, %rax
               	shlq	%rax
               	cmpl	%eax, %r9d
               	jl	<addr>
               	incq	%r14
               	cmpl	$0x2, %r14d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	-0x58(%rbp), %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x2, %ebx
               	jmp	<addr>
               	movq	-0x58(%rbp), %r10
               	incq	%r10
               	movq	%r10, -0x58(%rbp)
               	movq	-0x58(%rbp), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x40, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq

<check_unpacks>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x68, %rsp
               	pushq	%r15
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0xe0, %rsp
               	andq	$-0x20, %rsp
               	movq	%rdi, -0x48(%rbp)
               	movq	%rsi, -0x50(%rbp)
               	leaq	(%rsp), %rax
               	movq	-0x48(%rbp), %r10
               	movups	(%r10), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%r10), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	movq	(%rsp), %rax
               	movq	0x8(%rsp), %rcx
               	movq	0x10(%rsp), %rdx
               	movq	0x18(%rsp), %rsi
               	leaq	(%rsp), %rdi
               	movq	-0x50(%rbp), %r10
               	movups	(%r10), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%r10), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movq	(%rsp), %rdi
               	movq	0x8(%rsp), %r8
               	movq	0x10(%rsp), %r9
               	movq	0x18(%rsp), %rbx
               	leaq	(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movups	%xmm14, 0x10(%r12)
               	movups	%xmm14, 0x20(%r12)
               	movups	%xmm14, 0x30(%r12)
               	movups	%xmm14, 0x40(%r12)
               	movups	%xmm14, 0x50(%r12)
               	movups	%xmm14, 0x60(%r12)
               	movups	%xmm14, 0x70(%r12)
               	leaq	0xa0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rax, 0xa0(%rsp)
               	movq	%rcx, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rdi, 0xa0(%rsp)
               	movq	%r8, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm1
               	punpcklbw	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3],xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
               	leaq	0xb0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rdx, 0xb0(%rsp)
               	movq	%rsi, 0xb8(%rsp)
               	movups	0xb0(%rsp), %xmm1
               	leaq	0xb0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%r9, 0xb0(%rsp)
               	movq	%rbx, 0xb8(%rsp)
               	movups	0xb0(%rsp), %xmm2
               	punpcklbw	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1],xmm1[2],xmm2[2],xmm1[3],xmm2[3],xmm1[4],xmm2[4],xmm1[5],xmm2[5],xmm1[6],xmm2[6],xmm1[7],xmm2[7]
               	movups	%xmm0, 0xc0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	movq	0xc0(%rsp), %r12
               	movq	0xc8(%rsp), %r13
               	movq	0x80(%rsp), %r14
               	movq	0x88(%rsp), %r15
               	movq	%r12, (%rsp)
               	movq	%r13, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xa0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rax, 0xa0(%rsp)
               	movq	%rcx, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rdi, 0xa0(%rsp)
               	movq	%r8, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm1
               	punpcklwd	%xmm1, %xmm0    # xmm0 = xmm0[0],xmm1[0],xmm0[1],xmm1[1],xmm0[2],xmm1[2],xmm0[3],xmm1[3]
               	leaq	0xb0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rdx, 0xb0(%rsp)
               	movq	%rsi, 0xb8(%rsp)
               	movups	0xb0(%rsp), %xmm1
               	leaq	0xb0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%r9, 0xb0(%rsp)
               	movq	%rbx, 0xb8(%rsp)
               	movups	0xb0(%rsp), %xmm2
               	punpcklwd	%xmm2, %xmm1    # xmm1 = xmm1[0],xmm2[0],xmm1[1],xmm2[1],xmm1[2],xmm2[2],xmm1[3],xmm2[3]
               	movups	%xmm0, 0xc0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	movq	0xc0(%rsp), %r13
               	movq	0xc8(%rsp), %r14
               	movq	0x80(%rsp), %r15
               	movq	0x88(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	leaq	(%rsp), %r12
               	addq	$0x20, %r12
               	movq	%r13, (%r12)
               	movq	%r14, 0x8(%r12)
               	movq	%r15, 0x10(%r12)
               	movq	-0x58(%rbp), %r11
               	movq	%r11, 0x18(%r12)
               	leaq	0xa0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rax, 0xa0(%rsp)
               	movq	%rcx, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rdi, 0xa0(%rsp)
               	movq	%r8, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm1
               	punpckhbw	%xmm1, %xmm0    # xmm0 = xmm0[8],xmm1[8],xmm0[9],xmm1[9],xmm0[10],xmm1[10],xmm0[11],xmm1[11],xmm0[12],xmm1[12],xmm0[13],xmm1[13],xmm0[14],xmm1[14],xmm0[15],xmm1[15]
               	leaq	0xb0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rdx, 0xb0(%rsp)
               	movq	%rsi, 0xb8(%rsp)
               	movups	0xb0(%rsp), %xmm1
               	leaq	0xb0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%r9, 0xb0(%rsp)
               	movq	%rbx, 0xb8(%rsp)
               	movups	0xb0(%rsp), %xmm2
               	punpckhbw	%xmm2, %xmm1    # xmm1 = xmm1[8],xmm2[8],xmm1[9],xmm2[9],xmm1[10],xmm2[10],xmm1[11],xmm2[11],xmm1[12],xmm2[12],xmm1[13],xmm2[13],xmm1[14],xmm2[14],xmm1[15],xmm2[15]
               	movups	%xmm0, 0xc0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	movq	0xc0(%rsp), %r13
               	movq	0xc8(%rsp), %r14
               	movq	0x80(%rsp), %r15
               	movq	0x88(%rsp), %r10
               	movq	%r10, -0x58(%rbp)
               	leaq	(%rsp), %r12
               	addq	$0x40, %r12
               	movq	%r13, (%r12)
               	movq	%r14, 0x8(%r12)
               	movq	%r15, 0x10(%r12)
               	movq	-0x58(%rbp), %r11
               	movq	%r11, 0x18(%r12)
               	leaq	0xa0(%rsp), %r12
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%r12)
               	movq	%rax, 0xa0(%rsp)
               	movq	%rcx, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm0
               	leaq	0xa0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdi, 0xa0(%rsp)
               	movq	%r8, 0xa8(%rsp)
               	movups	0xa0(%rsp), %xmm1
               	punpckhwd	%xmm1, %xmm0    # xmm0 = xmm0[4],xmm1[4],xmm0[5],xmm1[5],xmm0[6],xmm1[6],xmm0[7],xmm1[7]
               	leaq	0xb0(%rsp), %rax
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%rdx, 0xb0(%rsp)
               	leaq	0xb0(%rsp), %rax
               	movq	%rsi, 0xb8(%rsp)
               	movups	0xb0(%rsp), %xmm1
               	xorps	%xmm14, %xmm14
               	movups	%xmm14, (%rax)
               	movq	%r9, 0xb0(%rsp)
               	movq	%rbx, 0xb8(%rsp)
               	movups	0xb0(%rsp), %xmm2
               	punpckhwd	%xmm2, %xmm1    # xmm1 = xmm1[4],xmm2[4],xmm1[5],xmm2[5],xmm1[6],xmm2[6],xmm1[7],xmm2[7]
               	movups	%xmm0, 0xc0(%rsp)
               	movups	%xmm1, 0x80(%rsp)
               	movq	0xc0(%rsp), %rcx
               	movq	0xc8(%rsp), %rdx
               	movq	0x80(%rsp), %rsi
               	movq	0x88(%rsp), %rdi
               	leaq	(%rsp), %rax
               	addq	$0x60, %rax
               	movq	%rcx, (%rax)
               	movq	%rdx, 0x8(%rax)
               	movq	%rsi, 0x10(%rax)
               	movq	%rdi, 0x18(%rax)
               	xorl	%r10d, %r10d
               	movq	%r10, -0x58(%rbp)
               	movq	-0x58(%rbp), %rax
               	cmpl	$0x4, %eax
               	jge	<addr>
               	testb	$0x1, %al
               	je	<addr>
               	movl	$0x2, %ecx
               	movl	$0x10, %eax
               	cltd
               	idivl	%ecx
               	movq	%rax, %r15
               	movq	-0x58(%rbp), %rax
               	cmpl	$0x2, %eax
               	jl	<addr>
               	movq	%r15, %r14
               	shrq	%r14
               	xorl	%r13d, %r13d
               	xorl	%r12d, %r12d
               	movq	%r15, %rax
               	shrq	%rax
               	cmpl	%eax, %r12d
               	jge	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	%r13, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rax,%rdx), %r9
               	movq	%r12, %rax
               	shlq	%rax
               	movq	-0x48(%rbp), %rsi
               	addq	%rdx, %rsi
               	leaq	(%r14,%r12), %rdi
               	xorl	%r8d, %r8d
               	leaq	-0x1(%rcx), %rdx
               	testl	%edx, %edx
               	jl	<addr>
               	shlq	$0x8, %r8
               	movq	%rcx, %rbx
               	imulq	%rdi, %rbx
               	addq	%rdx, %rbx
               	movslq	%ebx, %rbx
               	movzbq	(%rsi,%rbx), %rbx
               	orq	%rbx, %r8
               	decq	%rdx
               	testl	%edx, %edx
               	jge	<addr>
               	xorl	%edx, %edx
               	cmpl	%ecx, %edx
               	jge	<addr>
               	movq	%rcx, %rsi
               	imulq	%rax, %rsi
               	addq	%rdx, %rsi
               	movslq	%esi, %rsi
               	movq	%rdx, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %r8, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r9,%rsi)
               	incq	%rdx
               	cmpl	%ecx, %edx
               	jl	<addr>
               	leaq	-0x40(%rbp), %rax
               	movq	%r13, %rdx
               	shlq	$0x4, %rdx
               	leaq	(%rax,%rdx), %r9
               	movq	%r12, %rax
               	shlq	%rax
               	incq	%rax
               	movq	-0x50(%rbp), %rsi
               	addq	%rdx, %rsi
               	leaq	(%r14,%r12), %rdi
               	xorl	%r8d, %r8d
               	leaq	-0x1(%rcx), %rdx
               	testl	%edx, %edx
               	jl	<addr>
               	shlq	$0x8, %r8
               	movq	%rcx, %rbx
               	imulq	%rdi, %rbx
               	addq	%rdx, %rbx
               	movslq	%ebx, %rbx
               	movzbq	(%rsi,%rbx), %rbx
               	orq	%rbx, %r8
               	decq	%rdx
               	testl	%edx, %edx
               	jge	<addr>
               	xorl	%edx, %edx
               	cmpl	%ecx, %edx
               	jge	<addr>
               	movq	%rcx, %rsi
               	imulq	%rax, %rsi
               	addq	%rdx, %rsi
               	movslq	%esi, %rsi
               	movq	%rdx, %rdi
               	shlq	$0x3, %rdi
               	movslq	%edi, %rdi
               	shrxq	%rdi, %r8, %rdi
               	andq	$0xff, %rdi
               	movb	%dil, (%r9,%rsi)
               	incq	%rdx
               	cmpl	%ecx, %edx
               	jl	<addr>
               	incq	%r12
               	movq	%r15, %rax
               	shrq	%rax
               	cmpl	%eax, %r12d
               	jl	<addr>
               	incq	%r13
               	cmpl	$0x2, %r13d
               	jl	<addr>
               	leaq	(%rsp), %rax
               	movq	-0x58(%rbp), %rcx
               	shlq	$0x5, %rcx
               	addq	%rax, %rcx
               	leaq	-0x40(%rbp), %rsi
               	leaq	0x80(%rsp), %rax
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	0x10(%rcx), %xmm14
               	movups	%xmm14, 0x10(%rax)
               	leaq	-0x20(%rbp), %rdi
               	movups	(%rax), %xmm14
               	movups	%xmm14, (%rdi)
               	movups	0x10(%rax), %xmm14
               	movups	%xmm14, 0x10(%rdi)
               	movl	$0x20, %edx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	xorl	%r14d, %r14d
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movq	-0x58(%rbp), %r10
               	incq	%r10
               	movq	%r10, -0x58(%rbp)
               	movq	-0x58(%rbp), %rax
               	cmpl	$0x4, %eax
               	jl	<addr>
               	xorl	%eax, %eax
               	leaq	-0x90(%rbp), %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	popq	%r15
               	leave
               	retq
               	movl	$0x80, %eax
               	leaq	-0x90(%rbp), %rsp
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
               	subq	$0x40, %rsp
               	pushq	%r12
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	movq	%rbx, %r12
               	leaq	-0x40(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3c, %rsi
               	cmpl	$0x4, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x3a, %rcx
               	andq	$0x3, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	jmp	<addr>
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	leaq	-0x20(%rbp), %rdx
               	xorl	%eax, %eax
               	movq	<rip>, %rcx # <addr>
               	movq	%rcx, %rsi
               	shrq	$0xc, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shlq	$0x19, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rsi
               	shrq	$0x1b, %rsi
               	xorq	%rsi, %rcx
               	movq	%rcx, <rip> # <addr>
               	movabsq	$0x2545f4914f6cdd1d, %r11 # imm = 0x2545F4914F6CDD1D
               	imulq	%r11, %rcx
               	movq	%rcx, %rsi
               	shrq	$0x3c, %rsi
               	cmpl	$0x4, %esi
               	jae	<addr>
               	leaq	<rip>, %rsi # <addr>
               	shrq	$0x3a, %rcx
               	andq	$0x3, %rcx
               	movzbq	(%rsi,%rcx), %rcx
               	jmp	<addr>
               	shrq	$0x18, %rcx
               	andq	$0xff, %rcx
               	movb	%cl, (%rdx,%rax)
               	incq	%rax
               	cmpl	$0x20, %eax
               	jl	<addr>
               	imulq	$0x33333334, %rbx, %rax # imm = 0x33333334
               	shrq	$0x20, %rax
               	leaq	(%rax,%rax,4), %rax
               	movq	%rbx, %rcx
               	subq	%rax, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	-0x20(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	-0x40(%rbp), %rcx
               	addq	$0x8, %rcx
               	movq	(%rcx), %r10
               	movq	%r10, (%rax)
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %r12
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %r12
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %r12
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %r12
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %r12
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %r12
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %r12
               	leaq	-0x40(%rbp), %rdi
               	leaq	-0x20(%rbp), %rsi
               	callq	<addr>
               	orq	%rax, %r12
               	incq	%rbx
               	cmpl	$0x12c, %ebx            # imm = 0x12C
               	jl	<addr>
               	movq	%r12, %rax
               	popq	%rbx
               	popq	%r12
               	leave
               	retq
