
large_int_literal_auto_promotes.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movabsq	$0x7fffffffffffffff, %r11 # imm = 0x7FFFFFFFFFFFFFFF
               	movabsq	$-0x8000000000000000, %r9 # imm = 0x8000000000000000
               	movabsq	$0x7fffffffffffffff, %r10 # imm = 0x7FFFFFFFFFFFFFFF
               	movq	%r11, %r8
               	cmpq	%r10, %r11
               	je	0x40027a <.text+0x5a>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%r9, %r8
               	cmpq	%r11, %r9
               	je	0x40029e <.text+0x7e>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x7ffffffffffffffe, %r8 # imm = 0x7FFFFFFFFFFFFFFE
               	movabsq	$0x7ffffffffffffffe, %r11 # imm = 0x7FFFFFFFFFFFFFFE
               	movq	%r8, %rax
               	cmpq	%r11, %r8
               	je	0x4002d0 <.text+0xb0>
               	movl	$0x3, %r8d
               	movq	%r8, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x8000000000000000, %rax # imm = 0x8000000000000000
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	movq	%rax, %r8
               	cmpq	%r11, %rax
               	je	0x4002fe <.text+0xde>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x12a05f201, %r8       # imm = 0x12A05F201
               	movabsq	$0x12a05f201, %r11      # imm = 0x12A05F201
               	movq	%r8, %rax
               	cmpq	%r11, %r8
               	je	0x400330 <.text+0x110>
               	movl	$0x5, %r8d
               	movq	%r8, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
