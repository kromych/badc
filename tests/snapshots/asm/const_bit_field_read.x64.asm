
const_bit_field_read.x64:	file format elf64-x86-64

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
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	xorq	$0x64, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x1, %eax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$0xabcdef0123, %r11     # imm = 0xABCDEF0123
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	<rip>, %eax # <addr>
               	xorq	$0xabc, %rax            # imm = 0xABC
               	testl	%eax, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x2, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x65, %rax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$-0x6, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x123456789abcdef, %r11 # imm = 0xFEDCBA9876543211
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq
