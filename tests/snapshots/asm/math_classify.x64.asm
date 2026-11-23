
math_classify.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	xorl	%ecx, %ecx
               	movq	%rcx, %xmm14
               	movq	%rcx, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm0
               	movq	%xmm0, %rax
               	movq	%rax, %rdx
               	shrq	$0x34, %rdx
               	andq	$0x7ff, %rdx            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %rsi  # imm = 0xFFFFFFFFFFFFF
               	andq	%rax, %rsi
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x2, %ecx
               	movl	$0x3, %edi
               	testq	%rsi, %rsi
               	cmovneq	%rdi, %rcx
               	testl	%ecx, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	testl	%edx, %edx
               	jne	<addr>
               	movl	$0x2, %ecx
               	movl	$0x3, %edx
               	testq	%rsi, %rsi
               	cmovneq	%rdx, %rcx
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
               	cmpl	$0x7ff, %edx            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %ecx
               	xorl	%edx, %edx
               	testq	%rsi, %rsi
               	cmovneq	%rdx, %rcx
               	jmp	<addr>
               	cmpl	$0x7ff, %edx            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %edi
               	testq	%rsi, %rsi
               	cmoveq	%rdi, %rcx
               	jmp	<addr>
