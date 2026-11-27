
unread_narrowing_shift.x64:	file format elf64-x86-64

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

<narrow32>:
               	shlq	$0x20, %rdi
               	leaq	0x1(%rdi), %rax
               	retq

<narrow48>:
               	shlq	$0x30, %rdi
               	xorq	$0x1, %rdi
               	movq	%rdi, %rax
               	retq

<narrow56>:
               	shlq	$0x38, %rdi
               	orq	$0x1, %rdi
               	movq	%rdi, %rax
               	retq

<main>:
               	pushq	%rax
               	movq	<rip>, %rdi # <addr>
               	movl	$0x1, %esi
               	callq	<addr>
               	movabsq	$0x300000001, %r11      # imm = 0x300000001
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rdi # <addr>
               	movl	$0x1, %esi
               	callq	<addr>
               	movabsq	$0x5000000000001, %r11  # imm = 0x5000000000001
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rdi # <addr>
               	movl	$0x1, %esi
               	callq	<addr>
               	movabsq	$0x700000000000001, %r11 # imm = 0x700000000000001
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
