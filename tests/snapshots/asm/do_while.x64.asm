
do_while.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	jmp	0x40024e <.text+0x2e>
               	movslq	-0x8(%rbp), %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %r11
               	movl	%r11d, -0x8(%rbp)
               	jmp	0x400265 <.text+0x45>
               	movslq	-0x8(%rbp), %r11
               	cmpq	$0x5, %r11
               	jl	0x40024e <.text+0x2e>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
