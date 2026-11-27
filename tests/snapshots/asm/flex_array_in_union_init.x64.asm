
flex_array_in_union_init.x64:	file format elf64-x86-64

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
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x24, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x1, %eax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%r11
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xa5a5a5a5, %eax       # imm = 0xA5A5A5A5
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%r11
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x15, %eax
               	popq	%r11
               	retq
               	movq	<rip>, %rax # <addr>
               	movabsq	$0x1122334455667788, %r11 # imm = 0x1122334455667788
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x16, %eax
               	popq	%r11
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x33333333, %eax       # imm = 0x33333333
               	je	<addr>
               	movl	$0x17, %eax
               	popq	%r11
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x3, %eax
               	je	<addr>
               	movl	$0x28, %eax
               	popq	%r11
               	retq
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x7, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x8, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x29, %eax
               	popq	%r11
               	retq
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x55555555, %eax       # imm = 0x55555555
               	je	<addr>
               	movl	$0x2a, %eax
               	popq	%r11
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	xorl	%eax, %eax
               	popq	%r11
               	retq
