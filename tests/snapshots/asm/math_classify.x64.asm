
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
               	movabsq	$0x7ff0000000000000, %rcx # imm = 0x7FF0000000000000
               	movabsq	$-0x10000000000000, %rsi # imm = 0xFFF0000000000000
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, %rdi
               	shrq	$0x34, %rdi
               	andq	$0x7ff, %rdi            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rdx
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x2, %edi
               	movl	$0x3, %r8d
               	testq	%rdx, %rdx
               	movq	%rdi, %rdx
               	cmovneq	%r8, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movabsq	$0x3ff8000000000000, %rdx # imm = 0x3FF8000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x8(%rbp), %rdx
               	movq	%rdx, %rdi
               	shrq	$0x34, %rdi
               	andq	$0x7ff, %rdi            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rdx
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x2, %eax
               	movl	$0x3, %edi
               	testq	%rdx, %rdx
               	cmovneq	%rdi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rdx
               	shrq	$0x34, %rdx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x2, %edx
               	movl	$0x3, %edi
               	testq	%rax, %rax
               	movq	%rdx, %rax
               	cmovneq	%rdi, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	%rcx, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rdx
               	shrq	$0x34, %rdx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x2, %edx
               	movl	$0x3, %edi
               	testq	%rax, %rax
               	movq	%rdx, %rax
               	cmovneq	%rdi, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movq	%rsi, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rdx
               	shrq	$0x34, %rdx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x2, %edx
               	movl	$0x3, %edi
               	testq	%rax, %rax
               	movq	%rdx, %rax
               	cmovneq	%rdi, %rax
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	movabsq	$0x3ff8000000000000, %rdx # imm = 0x3FF8000000000000
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rdi
               	shrq	$0x34, %rdi
               	andq	$0x7ff, %rdi            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%edi, %edi
               	jne	<addr>
               	movl	$0x2, %edi
               	movl	$0x3, %r8d
               	testq	%rax, %rax
               	movq	%rdi, %rax
               	cmovneq	%r8, %rax
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
               	movl	$0x2, %edi
               	movl	$0x3, %r8d
               	testq	%rax, %rax
               	movq	%rdi, %rax
               	cmovneq	%r8, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rdx
               	shrq	$0x34, %rdx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x2, %edx
               	movl	$0x3, %edi
               	testq	%rax, %rax
               	movq	%rdx, %rax
               	cmovneq	%rdi, %rax
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorl	%edx, %edx
               	movq	%rdx, %xmm14
               	movsd	%xmm14, -0x8(%rbp)
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
               	movl	$0x2, %edi
               	movl	$0x3, %r8d
               	testq	%rax, %rax
               	movq	%rdi, %rax
               	cmovneq	%r8, %rax
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xa, %eax
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
               	movl	$0x2, %edx
               	movl	$0x3, %edi
               	testq	%rax, %rax
               	movq	%rdx, %rax
               	cmovneq	%rdi, %rax
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	leave
               	retq
               	movsd	%xmm0, -0x8(%rbp)
               	movq	-0x8(%rbp), %rax
               	movq	%rax, %rdx
               	shrq	$0x34, %rdx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x2, %edx
               	movl	$0x3, %edi
               	testq	%rax, %rax
               	movq	%rdx, %rax
               	cmovneq	%rdi, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xc, %eax
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
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	testq	%rax, %rax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
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
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	cmpl	$0x7ff, %edx            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %edx
               	xorl	%edi, %edi
               	testq	%rax, %rax
               	movq	%rdx, %rax
               	cmovneq	%rdi, %rax
               	jmp	<addr>
               	cmpl	$0x7ff, %edi            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %edi
               	testq	%rax, %rax
               	movq	%rdi, %rax
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %edi            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %edi
               	testq	%rax, %rax
               	movq	%rdi, %rax
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %edx            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %edx
               	xorl	%edi, %edi
               	testq	%rax, %rax
               	movq	%rdx, %rax
               	cmovneq	%rdi, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %edi            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %edi
               	xorl	%r8d, %r8d
               	testq	%rax, %rax
               	movq	%rdi, %rax
               	cmovneq	%r8, %rax
               	jmp	<addr>
               	cmpl	$0x7ff, %edi            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %edi
               	xorl	%r8d, %r8d
               	testq	%rax, %rax
               	movq	%rdi, %rax
               	cmovneq	%r8, %rax
               	jmp	<addr>
               	cmpl	$0x7ff, %edx            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %edx
               	xorl	%edi, %edi
               	testq	%rax, %rax
               	movq	%rdx, %rax
               	cmovneq	%rdi, %rax
               	jmp	<addr>
               	cmpl	$0x7ff, %edx            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %edx
               	xorl	%edi, %edi
               	testq	%rax, %rax
               	movq	%rdx, %rax
               	cmovneq	%rdi, %rax
               	jmp	<addr>
               	cmpl	$0x7ff, %edx            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %edx
               	xorl	%edi, %edi
               	testq	%rax, %rax
               	movq	%rdx, %rax
               	cmovneq	%rdi, %rax
               	jmp	<addr>
               	cmpl	$0x7ff, %edi            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %edi
               	testq	%rdx, %rdx
               	cmoveq	%rdi, %rax
               	jmp	<addr>
               	cmpl	$0x7ff, %edi            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %edi
               	testq	%rdx, %rdx
               	movq	%rdi, %rdx
               	cmovneq	%rax, %rdx
               	jmp	<addr>
