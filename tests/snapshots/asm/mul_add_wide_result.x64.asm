
mul_add_wide_result.x64:	file format elf64-x86-64

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

<macc>:
               	leaq	(%rdi,%rsi), %rax
               	movslq	%eax, %rax
               	imulq	%rdx, %rax
               	addq	%rcx, %rax
               	retq

<macc_sub>:
               	movslq	%edi, %rdi
               	movq	%rdi, %rcx
               	imulq	%rsi, %rcx
               	movq	%rdx, %rax
               	subq	%rcx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7fffffff, %edi       # imm = 0x7FFFFFFF
               	movl	$0x1, %esi
               	movl	$0x3, %edx
               	movl	$0x64, %ecx
               	callq	<addr>
               	movabsq	$-0x17fffff9c, %r11     # imm = 0xFFFFFFFE80000064
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	$-0x4, %rdi
               	xorl	%esi, %esi
               	movl	$0x3b9aca00, %edx       # imm = 0x3B9ACA00
               	movq	%rsi, %rcx
               	callq	<addr>
               	movabsq	$-0xee6b2800, %r11      # imm = 0xFFFFFFFF1194D800
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x2, %edi
               	movl	$0x3, %esi
               	movl	$0x7, %edx
               	movq	$-0x1, %rcx
               	callq	<addr>
               	cmpq	$0x22, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	$-0x5, %rdi
               	movl	$0x3b9aca00, %esi       # imm = 0x3B9ACA00
               	xorl	%edx, %edx
               	callq	<addr>
               	movabsq	$0x12a05f200, %r11      # imm = 0x12A05F200
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	movl	$0xf4240, %edi          # imm = 0xF4240
               	xorl	%edx, %edx
               	movq	%rdi, %rsi
               	callq	<addr>
               	movabsq	$-0xe8d4a51000, %r11    # imm = 0xFFFFFF172B5AF000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
