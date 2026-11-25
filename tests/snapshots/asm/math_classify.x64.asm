
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
               	xorl	%edx, %edx
               	movq	%rdx, %xmm14
               	movq	%rdx, %xmm15
               	vdivsd	%xmm15, %xmm14, %xmm0
               	movq	%xmm0, %rcx
               	movq	%rcx, %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %rsi  # imm = 0xFFFFFFFFFFFFF
               	andq	%rcx, %rsi
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %edx
               	movl	$0x3, %edi
               	testq	%rsi, %rsi
               	cmovneq	%rdi, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	movl	$0x3, %edx
               	testq	%rsi, %rsi
               	cmovneq	%rdx, %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movl	$0x7, %eax
               	retq
               	movq	%rcx, %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	movl	$0x3, %edx
               	testq	%rcx, %rcx
               	cmovneq	%rdx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	movq	%xmm0, %rcx
               	movq	%rcx, %rax
               	shrq	$0x34, %rax
               	andq	$0x7ff, %rax            # imm = 0x7FF
               	movabsq	$0xfffffffffffff, %r11  # imm = 0xFFFFFFFFFFFFF
               	andq	%r11, %rcx
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0x2, %eax
               	movl	$0x3, %edx
               	testq	%rcx, %rcx
               	cmovneq	%rdx, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xc, %eax
               	retq
               	xorl	%eax, %eax
               	retq
               	cmpl	$0x7ff, %eax            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %eax
               	xorl	%edx, %edx
               	testq	%rcx, %rcx
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	cmpl	$0x7ff, %eax            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %eax
               	xorl	%edx, %edx
               	testq	%rcx, %rcx
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	movl	$0x4, %eax
               	jmp	<addr>
               	cmpl	$0x7ff, %eax            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %eax
               	xorl	%edx, %edx
               	testq	%rsi, %rsi
               	cmovneq	%rdx, %rax
               	jmp	<addr>
               	cmpl	$0x7ff, %eax            # imm = 0x7FF
               	jne	<addr>
               	movl	$0x1, %edi
               	testq	%rsi, %rsi
               	cmoveq	%rdi, %rdx
               	jmp	<addr>
