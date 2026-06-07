
mul_pow2_to_shift.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12,%rbx,8), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %rax
               	xorq	%rdi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x8, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rcx
               	addq	$0x10, %rcx
               	leaq	<rip>, %rax
               	movq	%rax, (%rcx)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	jmp	<addr>
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xa0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movl	$0x7, %eax
               	movq	%rax, %rcx
               	shlq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	movq	%rax, %rdx
               	shlq	$0x2, %rdx
               	movslq	%edx, %rdx
               	movq	%rax, %rsi
               	shlq	$0x3, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %rdi
               	shlq	$0x4, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r8
               	shlq	$0xa, %r8
               	movslq	%r8d, %r8
               	movq	%rax, %r9
               	shlq	$0x1, %r9
               	movl	%r9d, %r9d
               	movq	%rax, %r11
               	shlq	$0x8, %r11
               	movl	%r11d, %r11d
               	movq	%rax, %rbx
               	shlq	$0x5, %rbx
               	shlq	$0x10, %rax
               	movslq	%ecx, %r12
               	movslq	%edx, %rcx
               	addq	%rcx, %r12
               	movslq	%r12d, %rdx
               	movslq	%esi, %rcx
               	addq	%rcx, %rdx
               	movslq	%edx, %rdx
               	movslq	%edi, %rcx
               	addq	%rcx, %rdx
               	movslq	%edx, %rdx
               	movslq	%r8d, %rcx
               	addq	%rcx, %rdx
               	movslq	%edx, %r12
               	movl	%r9d, %r9d
               	addq	%r9, %r12
               	movl	%r12d, %r12d
               	movl	%r11d, %r11d
               	addq	%r11, %r12
               	movl	%r12d, %r12d
               	addq	%rbx, %r12
               	addq	%rax, %r12
               	leaq	<rip>, %rdi
               	movq	%r12, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x724c0, %r12          # imm = 0x724C0
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0xa0, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
