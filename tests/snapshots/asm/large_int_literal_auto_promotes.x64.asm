
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
               	cmpq	%r10, %r11
               	je	0x400277 <.text+0x57>
               	movl	$0x1, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %r9
               	je	0x400298 <.text+0x78>
               	movl	$0x2, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x7ffffffffffffffe, %r9 # imm = 0x7FFFFFFFFFFFFFFE
               	movabsq	$0x7ffffffffffffffe, %r11 # imm = 0x7FFFFFFFFFFFFFFE
               	cmpq	%r11, %r9
               	je	0x4002c3 <.text+0xa3>
               	movl	$0x3, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$-0x8000000000000000, %r9 # imm = 0x8000000000000000
               	movabsq	$-0x8000000000000000, %r11 # imm = 0x8000000000000000
               	cmpq	%r11, %r9
               	je	0x4002ee <.text+0xce>
               	movl	$0x4, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	movabsq	$0x12a05f201, %r9       # imm = 0x12A05F201
               	movabsq	$0x12a05f201, %r11      # imm = 0x12A05F201
               	cmpq	%r11, %r9
               	je	0x400319 <.text+0xf9>
               	movl	$0x5, %eax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
