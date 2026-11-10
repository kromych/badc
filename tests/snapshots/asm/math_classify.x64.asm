
math_classify.x64:	file format elf64-x86-64

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
               	subq	$0x10, %rsp
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movq	%rax, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm0
               	movabsq	$0x7ff0000000000000, %rdx # imm = 0x7FF0000000000000
               	movabsq	$-0x10000000000000, %rsi # imm = 0xFFF0000000000000
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %rdi
               	shrq	$0x34, %rdi
               	andq	$0x7ff, %rdi            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testl	%edi, %edi
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %ecx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movabsq	$0x3ff8000000000000, %rcx # imm = 0x3FF8000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %rdi
               	shrq	$0x34, %rdi
               	andq	$0x7ff, %rdi            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testl	%edi, %edi
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	%rsi, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movabsq	$0x3ff8000000000000, %rcx # imm = 0x3FF8000000000000
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rdi
               	shrq	$0x34, %rdi
               	andq	$0x7ff, %rdi            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rdi
               	shrq	$0x34, %rdi
               	andq	$0x7ff, %rdi            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %rdi
               	shrq	$0x34, %rdi
               	andq	$0x7ff, %rdi            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testl	%edi, %edi
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %ecx
               	testl	%ecx, %ecx
               	je	<addr>
               	cmpl	$0x1, %ecx
               	je	<addr>
               	movl	$0xa, %eax
               	leave
               	retq
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	movq	%rcx, %rdi
               	shrq	$0x34, %rdi
               	andq	$0x7ff, %rdi            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testl	%edi, %edi
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	leave
               	retq
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%ecx, %ecx
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x2, %eax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xd, %eax
               	leave
               	retq
               	movabsq	$0x3ff8000000000000, %rax # imm = 0x3FF8000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0xe, %eax
               	leave
               	retq
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	je	<addr>
               	movq	%rsi, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x8(%rbp), %rcx
               	shrq	$0x3f, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0xf, %eax
               	leave
               	retq
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	shrq	$0x3f, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x10, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %edi            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	cmpl	$0x7ff, %edi            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movl	$0x4, %ecx
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %edi            # imm = 0x7FF
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %edi            # imm = 0x7FF
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	xorl	%eax, %eax
               	jmp	<addr>
               	movl	$0x3, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %edi            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %eax
               	jmp	<addr>
               	movl	$0x3, %ecx
               	jmp	<addr>
               	cmpl	$0x7ff, %edi            # imm = 0x7FF
               	jne	<addr>
               	testq	%rcx, %rcx
               	jne	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
