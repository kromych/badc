
unread_narrowing_shift.x64:	file format elf64-x86-64

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

<narrow32>:
               	movq	%rdi, %rax
               	shlq	$0x20, %rax
               	incq	%rax
               	retq

<narrow48>:
               	movq	%rdi, %rax
               	shlq	$0x30, %rax
               	xorq	$0x1, %rax
               	retq

<narrow56>:
               	movq	%rdi, %rax
               	shlq	$0x38, %rax
               	orq	$0x1, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	movabsq	$0x300000001, %r11      # imm = 0x300000001
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	0x8(%rax), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	movabsq	$0x5000000000001, %r11  # imm = 0x5000000000001
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax      # <addr>
               	movq	0x10(%rax), %rdi
               	movl	$0x1, %esi
               	callq	<addr>
               	movabsq	$0x700000000000001, %r11 # imm = 0x700000000000001
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
