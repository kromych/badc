
return_value_in_callee_saved.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rax
               	cmpq	$0x2, %rax
               	jge	<addr>
               	retq
               	retq
               	movslq	%edi, %r11
               	addq	$0x1, %r11
               	movslq	%r11d, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %edi
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
