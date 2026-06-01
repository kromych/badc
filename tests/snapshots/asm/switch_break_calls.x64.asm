
switch_break_calls.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movl	$0x64, %eax
               	retq
               	movl	$0xc8, %eax
               	retq
               	movl	$0x12c, %eax            # imm = 0x12C
               	retq
               	movl	$0x190, %eax            # imm = 0x190
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movslq	%edi, %r11
               	xorq	%r9, %r9
               	movl	%r9d, -0x8(%rbp)
               	jmp	<addr>
               	movslq	-0x8(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	movl	$0x64, %r9d
               	movl	%r9d, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0xc8, %r9d
               	movl	%r9d, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x12c, %r9d            # imm = 0x12C
               	movl	%r9d, -0x8(%rbp)
               	jmp	<addr>
               	movl	$0x190, %r9d            # imm = 0x190
               	movl	%r9d, -0x8(%rbp)
               	jmp	<addr>
               	cmpq	$0x0, %r11
               	je	<addr>
               	cmpq	$0x1, %r11
               	je	<addr>
               	cmpq	$0x2, %r11
               	je	<addr>
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x2, %edi
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, (%rax)
