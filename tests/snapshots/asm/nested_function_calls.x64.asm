
nested_function_calls.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %rax
               	movq	%rsi, %rcx
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	movl	$0xa, %eax
               	movl	$0x14, %ecx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movl	$0x1e, %ecx
               	movl	$0x28, %edx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	addb	%al, (%rax)
