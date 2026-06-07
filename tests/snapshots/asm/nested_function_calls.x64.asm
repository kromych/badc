
nested_function_calls.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	addq	%rsi, %rdi
               	movslq	%edi, %rax
               	retq
               	movl	$0xa, %edx
               	movl	$0x14, %eax
               	addq	%rax, %rdx
               	movslq	%edx, %rsi
               	movl	$0x1e, %edx
               	movl	$0x28, %eax
               	addq	%rax, %rdx
               	movslq	%edx, %rax
               	addq	%rax, %rsi
               	movslq	%esi, %rax
               	retq
