
call_arg_low_word.x64:	file format elf64-x86-64

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
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	movq	%rdi, %rax
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
               	subq	$0x18, %rsp
               	movabsq	$-0x21524110fffffffc, %rax # imm = 0xDEADBEEF00000004
               	movq	%rax, (%rsp)
               	movabsq	$0x12345678fffffffc, %rax # imm = 0x12345678FFFFFFFC
               	movq	%rax, 0x8(%rsp)
               	movq	(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	0x8(%rsp), %rdi
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	(%rsp), %rdi
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	addq	$0x18, %rsp
               	retq
               	movq	(%rsp), %rdi
               	movq	0x8(%rsp), %rsi
               	callq	<addr>
               	cmpq	$-0x1, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	<rip>, %rax # <addr>
               	leaq	0x20(%rax), %rdi
               	movq	(%rsp), %rsi
               	callq	<addr>
               	cmpq	$0xd, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	addq	$0x18, %rsp
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movq	(%rsp), %rsi
               	callq	<addr>
               	cmpq	$0xf, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	addq	$0x18, %rsp
               	retq
               	movabsq	$0x12345678ffffff85, %rdi # imm = 0x12345678FFFFFF85
               	callq	<addr>
               	cmpq	$-0x7b, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	addq	$0x18, %rsp
               	retq
               	movabsq	$-0x21524110edcb0002, %rdi # imm = 0xDEADBEEF1234FFFE
               	callq	<addr>
               	cmpq	$0xfffe, %rax           # imm = 0xFFFE
               	je	<addr>
               	movl	$0x8, %eax
               	addq	$0x18, %rsp
               	retq
               	xorl	%eax, %eax
               	addq	$0x18, %rsp
               	retq
