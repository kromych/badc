
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
               	movslq	(%r11), %rbx
               	addq	%rcx, %rbx
               	movslq	%ebx, %rbx
               	addq	%rsi, %r9
               	movslq	(%r9), %r9
               	subq	%rcx, %r9
               	movslq	%r9d, %r9
               	movslq	%r9d, %r9
               	movl	%r9d, (%r11)
               	movslq	%eax, %r9
               	movslq	%ebx, %r11
               	movl	%r11d, (%rsi,%r9,4)
               	movslq	%r8d, %r8
               	movslq	%eax, %r9
               	shlq	$0x2, %r9
               	movq	%rdi, %r11
               	addq	%r9, %r11
               	movslq	(%r11), %r11
               	addq	%rsi, %r9
               	movslq	(%r9), %r9
               	imulq	%r11, %r9
               	movslq	%r9d, %r9
               	addq	%r9, %r8
               	movslq	%r8d, %r8
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
               	movslq	%ecx, %rax
               	movq	%rax, %rcx
               	addq	$0x1, %rcx
               	jmp	<addr>
               	leaq	-0x20(%rbp), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, (%rax,%rdx,4)
               	leaq	-0x40(%rbp), %rax
               	movslq	%ecx, %rdx
               	movq	%rdx, %rsi
               	addq	$0x1, %rsi
               	movslq	%esi, %rsi
               	imulq	$0xa, %rsi, %rsi
               	movslq	%esi, %rsi
               	movl	%esi, (%rax,%rdx,4)
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
