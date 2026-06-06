
phi_class_nested_loops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	xorq	%rdx, %rdx
               	movq	%rdx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rsi
               	cmpq	%rax, %rsi
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	xorq	%rdi, %rdi
               	movq	%rdi, %rsi
               	jmp	<addr>
               	movslq	%edx, %rax
               	retq
               	movslq	%esi, %r8
               	cmpq	%rax, %r8
               	jge	<addr>
               	jmp	<addr>
               	movslq	%esi, %rsi
               	addq	$0x1, %rsi
               	jmp	<addr>
               	movslq	%edi, %rdi
               	addq	$0x1, %rdi
               	movslq	%edi, %rdi
               	jmp	<addr>
               	movslq	%edx, %rdx
               	movslq	%edi, %rsi
               	addq	%rsi, %rdx
               	movslq	%edx, %rdx
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %edi
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, (%rax)
