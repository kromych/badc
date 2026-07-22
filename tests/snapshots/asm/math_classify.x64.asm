
math_classify.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<signbit>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x8(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	shrq	$0x3f, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x260, %rsp            # imm = 0x260
               	xorq	%rax, %rax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rbp,%riz)
               	movsd	-0x8(%rbp,%riz), %xmm0
               	movapd	%xmm0, %xmm1
               	divsd	%xmm0, %xmm1
               	movabsq	$0x3ff0000000000000, %rax # imm = 0x3FF0000000000000
               	movq	%rax, %xmm2
               	divsd	%xmm0, %xmm2
               	movq	%rax, %xmm3
               	movabsq	$-0x8000000000000000, %r10 # imm = 0x8000000000000000
               	movq	%r10, %xmm15
               	xorpd	%xmm15, %xmm3
               	movapd	%xmm0, %xmm15
               	movapd	%xmm3, %xmm0
               	divsd	%xmm15, %xmm0
               	leaq	-0x30(%rbp), %rax
               	movsd	%xmm1, (%rax,%riz)
               	leaq	-0x30(%rbp), %rax
               	movq	(%rax), %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	leaq	-0x30(%rbp), %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	addq	$0x260, %rsp            # imm = 0x260
               	popq	%rbp
               	retq
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	leaq	-0x58(%rbp), %rcx
               	movq	%rax, %xmm14
               	movsd	%xmm14, (%rcx,%riz)
               	leaq	-0x58(%rbp), %rax
               	movq	(%rax), %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	leaq	-0x58(%rbp), %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x260, %rsp            # imm = 0x260
               	popq	%rbp
               	retq
               	leaq	-0x80(%rbp), %rax
               	movsd	%xmm2, (%rax,%riz)
               	leaq	-0x80(%rbp), %rax
               	movq	(%rax), %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	leaq	-0x80(%rbp), %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x260, %rsp            # imm = 0x260
               	popq	%rbp
               	retq
               	leaq	-0xa8(%rbp), %rax
               	movsd	%xmm2, (%rax,%riz)
               	leaq	-0xa8(%rbp), %rax
               	movq	(%rax), %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	leaq	-0xa8(%rbp), %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x4, %eax
               	addq	$0x260, %rsp            # imm = 0x260
               	popq	%rbp
               	retq
               	leaq	-0xd0(%rbp), %rax
               	movsd	%xmm0, (%rax,%riz)
               	leaq	-0xd0(%rbp), %rax
               	movq	(%rax), %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	leaq	-0xd0(%rbp), %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x5, %eax
               	addq	$0x260, %rsp            # imm = 0x260
               	popq	%rbp
               	retq
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	leaq	-0xf8(%rbp), %rcx
               	movq	%rax, %xmm14
               	movsd	%xmm14, (%rcx,%riz)
               	leaq	-0xf8(%rbp), %rax
               	movq	(%rax), %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	leaq	-0xf8(%rbp), %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x260, %rsp            # imm = 0x260
               	popq	%rbp
               	retq
               	leaq	-0x120(%rbp), %rax
               	movsd	%xmm1, (%rax,%riz)
               	leaq	-0x120(%rbp), %rax
               	movq	(%rax), %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	leaq	-0x120(%rbp), %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x260, %rsp            # imm = 0x260
               	popq	%rbp
               	retq
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	leaq	-0x148(%rbp), %rcx
               	movq	%rax, %xmm14
               	movsd	%xmm14, (%rcx,%riz)
               	leaq	-0x148(%rbp), %rax
               	movq	(%rax), %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	leaq	-0x148(%rbp), %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x8, %eax
               	addq	$0x260, %rsp            # imm = 0x260
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	leaq	-0x170(%rbp), %rcx
               	movq	%rax, %xmm14
               	movsd	%xmm14, (%rcx,%riz)
               	leaq	-0x170(%rbp), %rax
               	movq	(%rax), %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	leaq	-0x170(%rbp), %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x9, %eax
               	addq	$0x260, %rsp            # imm = 0x260
               	popq	%rbp
               	retq
               	leaq	-0x198(%rbp), %rax
               	movsd	%xmm2, (%rax,%riz)
               	leaq	-0x198(%rbp), %rax
               	movq	(%rax), %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	leaq	-0x198(%rbp), %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xa, %eax
               	addq	$0x260, %rsp            # imm = 0x260
               	popq	%rbp
               	retq
               	leaq	-0x1c0(%rbp), %rax
               	movsd	%xmm1, (%rax,%riz)
               	leaq	-0x1c0(%rbp), %rax
               	movq	(%rax), %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	leaq	-0x1c0(%rbp), %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	setge	%al
               	movzbq	%al, %rax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xb, %eax
               	addq	$0x260, %rsp            # imm = 0x260
               	popq	%rbp
               	retq
               	leaq	-0x1e8(%rbp), %rax
               	movsd	%xmm1, (%rax,%riz)
               	leaq	-0x1e8(%rbp), %rax
               	movq	(%rax), %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	leaq	-0x1e8(%rbp), %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0xc, %eax
               	addq	$0x260, %rsp            # imm = 0x260
               	popq	%rbp
               	retq
               	leaq	-0x210(%rbp), %rax
               	movsd	%xmm2, (%rax,%riz)
               	leaq	-0x210(%rbp), %rax
               	movq	(%rax), %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	leaq	-0x210(%rbp), %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rax
               	cmpq	$0x1, %rax
               	je	<addr>
               	movl	$0xd, %eax
               	addq	$0x260, %rsp            # imm = 0x260
               	popq	%rbp
               	retq
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	leaq	-0x238(%rbp), %rcx
               	movq	%rax, %xmm14
               	movsd	%xmm14, (%rcx,%riz)
               	leaq	-0x238(%rbp), %rax
               	movq	(%rax), %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	leaq	-0x238(%rbp), %rcx
               	movq	(%rcx), %rcx
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testq	%rax, %rax
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	movslq	%eax, %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0xe, %eax
               	addq	$0x260, %rsp            # imm = 0x260
               	popq	%rbp
               	retq
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xf, %eax
               	addq	$0x260, %rsp            # imm = 0x260
               	popq	%rbp
               	retq
               	movabsq	$0x3ff8000000000000, %rdi # imm = 0x3FF8000000000000
               	movq	%rdi, %xmm0
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	addq	$0x260, %rsp            # imm = 0x260
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x260, %rsp            # imm = 0x260
               	popq	%rbp
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$0x7ff, %rax            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$0x7ff, %rax            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$0x7ff, %rax            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$0x7ff, %rax            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$0x7ff, %rax            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$0x7ff, %rax            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$0x7ff, %rax            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$0x7ff, %rax            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$0x7ff, %rax            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$0x7ff, %rax            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$0x7ff, %rax            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$0x7ff, %rax            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$0x7ff, %rax            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpq	$0x7ff, %rax            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	movslq	%eax, %rax
               	jmp	<addr>
               	xorq	%rax, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
