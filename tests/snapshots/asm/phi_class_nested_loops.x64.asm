
phi_class_nested_loops.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rdi
               	xorq	%rcx, %rcx
               	movq	%rcx, %rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	cmpq	%rdi, %rdx
               	jge	<addr>
               	jmp	<addr>
               	movslq	%eax, %rax
               	addq	$0x1, %rax
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	movq	%rsi, %rdx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	retq
               	movslq	%edx, %r8
               	cmpq	%rdi, %r8
               	jge	<addr>
               	jmp	<addr>
               	movslq	%edx, %rdx
               	addq	$0x1, %rdx
               	jmp	<addr>
               	movslq	%esi, %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	jmp	<addr>
               	movslq	%ecx, %rdx
               	movslq	%esi, %rcx
               	addq	%rcx, %rdx
               	movslq	%edx, %rcx
               	jmp	<addr>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x7, %edi
               	popq	%rbp
               	jmp	<addr>
               	addb	%al, 0x41(%rdx)
