
for_loop_call_body_and_step.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %rax
               	retq
               	movslq	%edi, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	xorq	%r11, %r11
               	movl	%r11d, -0x8(%rbp)
               	movl	%r11d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r11
               	cmpq	$0x7, %r11
               	jge	<addr>
               	jmp	<addr>
               	movslq	-0x10(%rbp), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x10(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r9
               	addq	$0x1, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %r9
               	movl	$0x6, %r11d
               	imulq	%r11, %r9
               	movslq	%r9d, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
