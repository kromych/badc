
commutative_imm_lhs_swap.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	movl	$0x7, %r11d
               	movslq	%r11d, %r9
               	movq	%r9, %r8
               	shlq	$0x2, %r8
               	movslq	%r8d, %r8
               	cmpq	$0x1c, %r8
               	je	0x40025d <.text+0x3d>
               	movl	$0x1, %eax
               	retq
               	movslq	%r11d, %r9
               	movq	%r9, %rax
               	addq	$0x3, %rax
               	movslq	%eax, %rax
               	cmpq	$0xa, %rax
               	je	0x400280 <.text+0x60>
               	movl	$0x2, %eax
               	retq
               	movslq	%r11d, %r9
               	movq	%r9, %rax
               	andq	$0xf0, %rax
               	cmpq	$0x0, %rax
               	je	0x4002a0 <.text+0x80>
               	movl	$0x3, %eax
               	retq
               	movslq	%r11d, %r9
               	movq	%r9, %rax
               	orq	$0x10, %rax
               	cmpq	$0x17, %rax
               	je	0x4002c0 <.text+0xa0>
               	movl	$0x4, %eax
               	retq
               	movslq	%r11d, %r9
               	movq	%r9, %rax
               	xorq	$0xff, %rax
               	cmpq	$0xf8, %rax
               	je	0x4002e0 <.text+0xc0>
               	movl	$0x5, %eax
               	retq
               	movslq	%r11d, %r9
               	cmpq	$0x1, %r9
               	sete	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	je	0x400305 <.text+0xe5>
               	movl	$0x6, %eax
               	retq
               	movslq	%r11d, %r9
               	cmpq	$0x1, %r9
               	setne	%al
               	movzbq	%al, %rax
               	cmpq	$0x1, %rax
               	je	0x40032a <.text+0x10a>
               	movl	$0x7, %eax
               	retq
               	movl	$0xa, %r9d
               	movslq	%r11d, %rax
               	movq	%r9, %rdi
               	subq	%rax, %rdi
               	movslq	%edi, %rdi
               	cmpq	$0x3, %rdi
               	je	0x400352 <.text+0x132>
               	movl	$0x8, %edi
               	movq	%rdi, %rax
               	retq
               	movslq	%r11d, %rax
               	cmpq	$0x8, %rax
               	setl	%r11b
               	movzbq	%r11b, %r11
               	cmpq	$0x0, %r11
               	jne	0x40037b <.text+0x15b>
               	movl	$0x9, %r11d
               	movq	%r11, %rax
               	retq
               	xorq	%rax, %rax
               	retq
