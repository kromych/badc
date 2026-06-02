
struct_field_assign_from_call.x64:	file format elf64-x86-64

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
               	movslq	%edi, %rbx
               	leaq	<rip>, %r9
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %r9
               	movq	(%r9), %r9
               	cmpq	$0x0, %r9
               	je	<addr>
               	leaq	<rip>, %r8
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	addq	%r9, %r8
               	movq	(%r8), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%rdi, %rdi
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	addq	$0x8, %rsi
               	leaq	<rip>, %r8
               	movq	%r8, (%rsi)
               	leaq	-0x18(%rbp), %r9
               	addq	$0x10, %r9
               	leaq	<rip>, %r8
               	movq	%r8, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	addq	%r8, %rsi
               	movq	(%rsi), %r8
               	movq	%r8, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	addq	%rsi, %rdi
               	movq	(%rax), %rax
               	movq	%rax, (%rdi)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	shlq	$0x3, %rbx
               	addq	%rbx, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movslq	%edx, %rdx
               	movslq	%ecx, %rcx
               	movslq	%r8d, %r8
               	movl	$0x4, %r9d
               	movl	%r9d, (%rsi)
               	movl	$0x1234abcd, %eax       # imm = 0x1234ABCD
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %r10
               	movq	%r10, 0x38(%rsp)
               	movq	%rsi, %r12
               	movq	0x38(%rsp), %r14
               	addq	$0x8, %r14
               	movq	(%r14), %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x38(%rsp), %rsi
               	addq	$0x18, %rsi
               	movq	(%rsi), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	(%r14), %rdi
               	movq	0x38(%rsp), %rsi
               	addq	$0x14, %rsi
               	movq	0x38(%rsp), %rcx
               	addq	$0x10, %rcx
               	movslq	(%rcx), %rcx
               	addq	$0x1, %rcx
               	movslq	%ecx, %rdx
               	movl	$0x10, %ebx
               	movl	$0x7fff, %r15d          # imm = 0x7FFF
               	movq	%rbx, %rcx
               	movq	%r12, %r9
               	movq	%r15, %r8
               	callq	<addr>
               	movq	%rax, (%r14)
               	movq	0x38(%rsp), %r14
               	addq	$0x18, %r14
               	movq	(%r14), %rdi
               	movq	0x38(%rsp), %rsi
               	addq	$0x24, %rsi
               	movq	0x38(%rsp), %rax
               	addq	$0x20, %rax
               	movslq	(%rax), %rax
               	addq	$0x1, %rax
               	movslq	%eax, %rdx
               	movq	%rbx, %rcx
               	movq	%r12, %r9
               	movq	%r15, %r8
               	callq	<addr>
               	movq	%rax, (%r14)
               	movq	0x38(%rsp), %r15
               	addq	$0x8, %r15
               	movq	(%r15), %r15
               	movq	0x28(%rsp), %rax
               	cmpq	%r15, %rax
               	jne	<addr>
               	movl	$0x1, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	0x38(%rsp), %rax
               	addq	$0x18, %rax
               	movq	(%rax), %rax
               	movq	0x30(%rsp), %r15
               	cmpq	%rax, %r15
               	jne	<addr>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	0x38(%rsp), %r15
               	addq	$0x8, %r15
               	movq	(%r15), %r15
               	cmpq	$0x1234abcd, %r15       # imm = 0x1234ABCD
               	je	<addr>
               	movl	$0x3, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	0x38(%rsp), %r15
               	addq	$0x18, %r15
               	movq	(%r15), %r15
               	cmpq	$0x1234abcd, %r15       # imm = 0x1234ABCD
               	je	<addr>
               	movl	$0x4, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	0x38(%rsp), %r15
               	addq	$0x14, %r15
               	movslq	(%r15), %r15
               	cmpq	$0x4, %r15
               	je	<addr>
               	movl	$0x5, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	0x38(%rsp), %r15
               	addq	$0x24, %r15
               	movslq	(%r15), %r15
               	cmpq	$0x4, %r15
               	je	<addr>
               	movl	$0x6, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%r15, %r15
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rdi
               	cmpq	$0x0, %rdi
               	je	<addr>
               	leaq	<rip>, %r8
               	movslq	%eax, %rsi
               	leaq	<rip>, %rax
               	movq	%rax, %r11
               	addq	$0x8, %r11
               	movq	(%r11), %rdx
               	movq	%rax, %r11
               	addq	$0x18, %r11
               	movq	(%r11), %rcx
               	movq	%rax, %r11
               	addq	$0x14, %r11
               	movslq	(%r11), %r9
               	addq	$0x24, %rax
               	movslq	(%rax), %r11
               	movq	%r8, %rdi
               	movq	%r9, %r8
               	movq	%r11, %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
