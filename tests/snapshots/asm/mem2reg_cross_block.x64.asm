
mem2reg_cross_block.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	$0xe, %r11d
               	xorq	%r9, %r9
               	movl	%r9d, -0x10(%rbp)
               	movl	%r9d, -0x18(%rbp)
               	jmp	0x400258 <.text+0x38>
               	movslq	-0x18(%rbp), %r9
               	cmpq	$0x3, %r9
               	jge	0x400295 <.text+0x75>
               	movslq	-0x10(%rbp), %r9
               	movslq	%r11d, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x10(%rbp)
               	movslq	-0x18(%rbp), %r8
               	movq	%r8, %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	movl	%edi, -0x18(%rbp)
               	jmp	0x400258 <.text+0x38>
               	movslq	-0x10(%rbp), %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	addb	%al, 0x41(%rdx)
