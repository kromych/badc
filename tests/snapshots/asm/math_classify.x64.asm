
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
               	xorl	%esi, %esi
               	movq	%rsi, %xmm14
               	movq	%rsi, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm0
               	movq	%xmm0, %rax
               	movq	%rax, %rcx
               	shrq	$0x34, %rcx
               	andq	$0x7ff, %rcx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %rdx  # imm = 0xFFFFFFFFFFFFF
               	andq	%rax, %rdx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x2, %esi
               	movl	$0x3, %edi
               	testq	%rdx, %rdx
               	cmovneq	%rdi, %rsi
               	testl	%esi, %esi
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	testl	%ecx, %ecx
               	jne	<addr>
               	movl	$0x2, %ecx
               	movl	$0x3, %esi
               	testq	%rdx, %rdx
               	cmovneq	%rsi, %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movl	$0x7, %eax
               	retq
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
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movq	%xmm0, %rax
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
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	testq	%rax, %rax
               	movq	%rcx, %rax
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%esi, %esi
               	testq	%rdx, %rdx
               	cmovneq	%rsi, %rcx
               	jmp	<addr>
               	cmpl	$0x7ff, %ecx            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %edi
               	testq	%rdx, %rdx
               	cmoveq	%rdi, %rsi
               	jmp	<addr>
