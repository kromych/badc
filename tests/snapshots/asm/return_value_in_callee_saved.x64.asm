
return_value_in_callee_saved.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	cmpq	$0x2, %rax
               	jge	<addr>
               	retq
               	retq
               	movslq	%edi, %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %edi
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, (%rax)
