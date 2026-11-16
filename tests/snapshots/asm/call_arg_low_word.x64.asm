
call_arg_low_word.x64:	file format elf64-x86-64

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

<scale>:
               	movl	%edi, %eax
               	leaq	(%rax,%rax,2), %rax
               	retq

<widen>:
               	movslq	%edi, %rax
               	retq

<halve>:
               	movl	%edi, %eax
               	shrq	%rax
               	retq

<sum>:
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	leaq	(%rdi,%rsi), %rax
               	retq

<pick>:
               	movslq	%esi, %rsi
               	movq	(%rdi,%rsi,8), %rax
               	retq

<pick_u>:
               	movl	%esi, %eax
               	movq	(%rdi,%rax,8), %rax
               	retq

<byte>:
               	movsbq	%dil, %rax
               	retq

<half>:
               	movq	%rdi, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	retq

<via_scale>:
               	orq	$0x1, %rdi
               	jmp	<addr>

<via_widen>:
               	incq	%rdi
               	jmp	<addr>

<via_halve>:
               	xorq	$0x2, %rdi
               	jmp	<addr>

<via_sum>:
               	decq	%rsi
               	jmp	<addr>

<via_pick>:
               	subq	$0x5, %rsi
               	jmp	<addr>

<via_pick_u>:
               	incq	%rsi
               	jmp	<addr>

<via_byte>:
               	jmp	<addr>

<via_half>:
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movabsq	$-0x21524110fffffffc, %rax # imm = 0xDEADBEEF00000004
               	movq	%rax, -0x10(%rbp)
               	movabsq	$0x12345678fffffffc, %rax # imm = 0x12345678FFFFFFFC
               	movq	%rax, -0x8(%rbp)
               	movq	-0x10(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	leave
               	retq
               	movq	-0x8(%rbp), %rdi
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	leave
               	retq
               	movq	-0x10(%rbp), %rdi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	movq	-0x10(%rbp), %rdi
               	movq	-0x8(%rbp), %rsi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x20(%rax), %rdi
               	movq	-0x10(%rbp), %rsi
               	callq	<addr>
               	cmpq	$0xd, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	leave
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movq	-0x10(%rbp), %rsi
               	callq	<addr>
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	movabsq	$0x12345678ffffff85, %rdi # imm = 0x12345678FFFFFF85
               	callq	<addr>
               	cmpq	$-0x7b, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	leave
               	retq
               	movabsq	$-0x21524110edcb0002, %rdi # imm = 0xDEADBEEF1234FFFE
               	callq	<addr>
               	cmpq	$0xfffe, %rax           # imm = 0xFFFE
               	je	<addr>
               	movl	$0x8, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
