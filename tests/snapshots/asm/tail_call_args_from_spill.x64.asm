
tail_call_args_from_spill.x64:	file format elf64-x86-64

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
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
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
               	leaq	-0x18(%rbp), %rax
               	addq	$0x8, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	addq	$0x10, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rax
               	movq	(%rax), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	cmpq	$0x0, %rax
               	je	<addr>
               	movq	%rbx, %rcx
               	shlq	$0x3, %rcx
               	addq	%r12, %rcx
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	addq	%r12, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	%rdi, %rax
               	movq	%rcx, %r10
               	movq	%rsi, %rcx
               	movq	%r10, %rsi
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	movslq	%edx, %rdx
               	movslq	%esi, %rsi
               	movslq	%eax, %rax
               	shlq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	imulq	$0x3, %rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	%rsi, %rcx
               	shlq	$0x2, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rcx
               	movq	%rax, %rdx
               	addq	$0x1, %rdx
               	movslq	%edx, %rdx
               	movq	%rax, %rsi
               	addq	$0x2, %rsi
               	movslq	%esi, %rsi
               	movq	%rax, %rdi
               	addq	$0x3, %rdi
               	movslq	%edi, %rdi
               	movq	%rax, %r8
               	addq	$0x4, %r8
               	movslq	%r8d, %r8
               	movq	%rax, %r9
               	addq	$0x5, %r9
               	movslq	%r9d, %r9
               	movq	%rax, %r11
               	addq	$0x6, %r11
               	movslq	%r11d, %r11
               	movq	%rax, %rbx
               	addq	$0x7, %rbx
               	movslq	%ebx, %rbx
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movslq	%r12d, %r12
               	movq	%rax, %r14
               	addq	$0x9, %r14
               	movslq	%r14d, %r14
               	movq	%rax, %r15
               	addq	$0xa, %r15
               	movslq	%r15d, %r15
               	movq	%rax, %r10
               	addq	$0xb, %r10
               	movq	%r10, 0xa0(%rsp)
               	movq	0x98(%rsp), %r10
               	movq	0xa0(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x90(%rsp)
               	movq	%rax, %r10
               	addq	$0xc, %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x78(%rsp), %r10
               	movq	0x80(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	%rax, %r10
               	addq	$0xd, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x58(%rsp), %r10
               	movq	0x60(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%rax, %r10
               	addq	$0xe, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	0x40(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x30(%rsp)
               	addq	$0xf, %rax
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	%edi, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	%r8d, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	%r11d, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	%ebx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	%r12d, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	%r14d, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	%r15d, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movq	0x90(%rsp), %rdx
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movq	0x70(%rsp), %rdx
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movq	0x30(%rsp), %rdx
               	movslq	%edx, %rdx
               	addq	%rdx, %rcx
               	movslq	%ecx, %rcx
               	movslq	%eax, %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movslq	%eax, %rax
               	cmpq	$0x0, %rax
               	jne	<addr>
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	movslq	%esi, %rax
               	movslq	%r9d, %rcx
               	movslq	%r14d, %rdx
               	movq	0x50(%rsp), %rsi
               	movslq	%esi, %rsi
               	movslq	%eax, %rax
               	shlq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	imulq	$0x3, %rdx, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	%rsi, %rcx
               	shlq	$0x2, %rcx
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xb0, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x30, %rsp
               	movq	%rbx, (%rsp)
               	movl	$0xa, %edi
               	callq	<addr>
               	movq	%rax, %rbx
               	leaq	<rip>, %rdi
               	movslq	%ebx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movslq	%ebx, %rax
               	cmpq	$0xbf, %rax
               	jne	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x30, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
