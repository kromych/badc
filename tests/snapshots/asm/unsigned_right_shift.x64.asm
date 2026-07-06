
unsigned_right_shift.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	movl	$0x80000000, %eax       # imm = 0x80000000
               	shrq	$0x1, %rax
               	movl	%eax, %eax
               	xorq	$0x40000000, %rax       # imm = 0x40000000
               	movl	%eax, %eax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	shrq	$0x1, %rax
               	movabsq	$0x4000000000000000, %r11 # imm = 0x4000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%rax, %rax
               	retq
               	addb	%al, (%rax)
