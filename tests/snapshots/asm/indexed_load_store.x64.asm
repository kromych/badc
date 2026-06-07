
indexed_load_store.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movslq	%edx, %rdx
               	movslq	%ecx, %rcx
               	xorq	%r8, %r8
               	movq	%r8, %rax
               	jmp	<addr>
               	movslq	%eax, %r9
               	cmpq	%rdx, %r9
               	jge	<addr>
               	jmp	<addr>
               	movslq	%eax, %rax
               	addq	$0x1, %rax
               	jmp	<addr>
               	movslq	%eax, %r9
               	shlq	$0x2, %r9
               	movq	%rdi, %r11
               	addq	%r9, %r11
               	movslq	(%r11), %r12
               	addq	%rcx, %r12
               	movslq	%r12d, %rbx
               	addq	%rsi, %r9
               	movslq	(%r9), %r9
               	subq	%rcx, %r9
               	movslq	%r9d, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%r11)
               	movslq	%eax, %r9
               	shlq	$0x2, %r9
               	addq	%rsi, %r9
               	movslq	%ebx, %r11
               	movl	%r11d, (%r9)
               	movslq	%r8d, %rbx
               	movslq	%eax, %r8
               	shlq	$0x2, %r8
               	movq	%rdi, %r9
               	addq	%r8, %r9
               	movslq	(%r9), %r11
               	addq	%rsi, %r8
               	movslq	(%r8), %r8
               	imulq	%r8, %r11
               	movslq	%r11d, %r8
               	addq	%r8, %rbx
               	movslq	%ebx, %r8
               	jmp	<addr>
               	movslq	%r8d, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x70, %rsp
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%ecx, %rax
               	cmpq	$0x8, %rax
               	jge	<addr>
               	jmp	<addr>
               	movslq	%ecx, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rdx
               	movslq	%ecx, %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rdx
               	addq	$0x1, %rsi
               	movslq	%esi, %rax
               	movl	%eax, (%rdx)
               	leaq	-0x40(%rbp), %rdx
               	movslq	%ecx, %rsi
               	movq	%rsi, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rdx
               	addq	$0x1, %rsi
               	movslq	%esi, %rax
               	imulq	$0xa, %rax, %rax
               	movslq	%eax, %rax
               	movl	%eax, (%rdx)
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rdi
               	leaq	-0x40(%rbp), %rsi
               	movl	$0x8, %edx
               	movl	$0x3, %ecx
               	callq	<addr>
               	cmpq	$0xb7c, %rax            # imm = 0xB7C
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movq	%rcx, %rax
               	addq	$0x70, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
