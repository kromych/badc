
sizeof_function_call_truncation.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %r11
               	movq	%r11, %r9
               	andq	$0xff, %r9
               	sarq	$0x8, %r11
               	andq	$0xff, %r11
               	movslq	%r9d, %r9
               	movslq	%r11d, %r11
               	addq	%r11, %r9
               	movslq	%r9d, %r9
               	movslq	%r9d, %r9
               	shlq	$0x1, %r9
               	movslq	%r9d, %r9
               	movslq	%r9d, %rax
               	retq
               	movl	$0x1234, %r11d          # imm = 0x1234
               	movq	%r11, %r9
               	andq	$0xff, %r9
               	sarq	$0x8, %r11
               	andq	$0xff, %r11
               	movslq	%r9d, %r9
               	movslq	%r11d, %r11
               	addq	%r11, %r9
               	movslq	%r9d, %r9
               	movslq	%r9d, %r9
               	shlq	$0x1, %r9
               	movslq	%r9d, %r9
               	movslq	%r9d, %r9
               	cmpq	$0x8c, %r9
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	andq	$0xff, %rax
               	sarq	$0x8, %r9
               	andq	$0xff, %r9
               	movslq	%eax, %rax
               	movslq	%r9d, %r9
               	addq	%r9, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	shlq	$0x1, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movl	$0x2, %r9d
               	movq	%r9, %rax
               	retq
               	movl	$0xff00, %eax           # imm = 0xFF00
               	movq	%rax, %r9
               	andq	$0xff, %r9
               	sarq	$0x8, %rax
               	andq	$0xff, %rax
               	movslq	%r9d, %r9
               	movslq	%eax, %rax
               	addq	%rax, %r9
               	movslq	%r9d, %r9
               	movslq	%r9d, %r9
               	shlq	$0x1, %r9
               	movslq	%r9d, %r9
               	movslq	%r9d, %r9
               	cmpq	$0x1fe, %r9             # imm = 0x1FE
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%r9, %r9
               	movq	%r9, %rax
               	retq
               	addb	%al, (%rax)
