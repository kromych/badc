
mem2reg_narrow_store_trunc.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400297 <.text+0x77>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %r11
               	movq	%r11, %r9
               	andq	$0xff, %r9
               	movq	%r9, %r11
               	xorq	$0x2c, %r11
               	movl	$0xffffffff, %r9d       # imm = 0xFFFFFFFF
               	andq	%r11, %r9
               	cmpq	$0x0, %r9
               	jne	0x40027b <.text+0x5b>
               	xorq	%r9, %r9
               	movq	%r9, -0x10(%rbp)
               	jmp	0x40028a <.text+0x6a>
               	movl	$0x1, %r9d
               	movq	%r9, -0x10(%rbp)
               	jmp	0x40028a <.text+0x6a>
               	movq	-0x10(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0x12c, %ebx            # imm = 0x12C
               	movq	%rbx, %rdi
               	movq	(%rsp), %rbx
               	addq	$0x10, %rsp
               	popq	%rbp
               	jmp	0x400237 <.text+0x17>
