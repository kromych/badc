
file_scope_asm_section_placement.x64:	file format elf64-x86-64

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
               	pushq	%rax
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %eax
               	cmpl	$0x11112222, %eax       # imm = 0x11112222
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %ecx
               	cmpl	$0x33334444, %ecx       # imm = 0x33334444
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %ecx
               	cmpl	$0x55556666, %ecx       # imm = 0x55556666
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movl	$0x77778888, (%rax)     # imm = 0x77778888
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movl	$0x2a, %eax
               	popq	%r11
               	retq
               	addb	%ah, 0x66(%rsi)

<asm_x_word>:
               	pushw	%bp
               	pushq	%rbp
