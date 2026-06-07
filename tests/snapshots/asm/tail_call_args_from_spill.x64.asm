
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
               	movq	%rdx, %r8
               	movslq	%edi, %rdi
               	movslq	%esi, %rsi
               	movslq	%r8d, %r8
               	movslq	%ecx, %rcx
               	movslq	%edi, %rdx
               	movq	%rsi, %rax
               	shlq	$0x1, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	leaq	(%r8,%r8,2), %r8
               	movslq	%r8d, %rax
               	addq	%rax, %rdx
               	movslq	%edx, %rdx
               	movq	%rcx, %rax
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rdx
               	movslq	%edx, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xb0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movslq	%edi, %rdi
               	movslq	%edi, %rax
               	movq	%rdi, %rcx
               	addq	$0x1, %rcx
               	movslq	%ecx, %rcx
               	movq	%rdi, %rdx
               	addq	$0x2, %rdx
               	movslq	%edx, %rdx
               	movq	%rdi, %rsi
               	addq	$0x3, %rsi
               	movslq	%esi, %rsi
               	movq	%rdi, %r8
               	addq	$0x4, %r8
               	movslq	%r8d, %r8
               	movq	%rdi, %r9
               	addq	$0x5, %r9
               	movslq	%r9d, %r9
               	movq	%rdi, %r11
               	addq	$0x6, %r11
               	movslq	%r11d, %r11
               	movq	%rdi, %rbx
               	addq	$0x7, %rbx
               	movslq	%ebx, %rbx
               	movq	%rdi, %r12
               	addq	$0x8, %r12
               	movslq	%r12d, %r12
               	movq	%rdi, %r14
               	addq	$0x9, %r14
               	movslq	%r14d, %r14
               	movq	%rdi, %r15
               	addq	$0xa, %r15
               	movslq	%r15d, %r15
               	movq	%rdi, %r10
               	addq	$0xb, %r10
               	movq	%r10, 0xa0(%rsp)
               	movq	0x98(%rsp), %r10
               	movq	0xa0(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x90(%rsp)
               	movq	%rdi, %r10
               	addq	$0xc, %r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x78(%rsp), %r10
               	movq	0x80(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	%rdi, %r10
               	addq	$0xd, %r10
               	movq	%r10, 0x60(%rsp)
               	movq	0x58(%rsp), %r10
               	movq	0x60(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x50(%rsp)
               	movq	%rdi, %r10
               	addq	$0xe, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x38(%rsp), %r10
               	movq	0x40(%rsp), %r10
               	movslq	%r10d, %r10
               	movq	%r10, 0x30(%rsp)
               	addq	$0xf, %rdi
               	movslq	%edi, %rdi
               	movslq	%eax, %rax
               	movslq	%ecx, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movslq	%esi, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movslq	%r8d, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	movslq	%r11d, %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ebx, %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movslq	%r12d, %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movslq	%r14d, %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movslq	%r15d, %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movq	0x90(%rsp), %rax
               	movslq	%eax, %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movq	0x70(%rsp), %rax
               	movslq	%eax, %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movq	0x30(%rsp), %rax
               	movslq	%eax, %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movslq	%edi, %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rax
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
               	movslq	%edx, %rax
               	movslq	%r9d, %rcx
               	movslq	%r14d, %rdi
               	movq	0x50(%rsp), %rdx
               	movslq	%edx, %rdx
               	movslq	%eax, %rsi
               	movq	%rcx, %rax
               	shlq	$0x1, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rsi
               	movslq	%esi, %rcx
               	leaq	(%rdi,%rdi,2), %rdi
               	movslq	%edi, %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rcx
               	movq	%rdx, %rax
               	shlq	$0x2, %rax
               	movslq	%eax, %rax
               	addq	%rax, %rcx
               	movslq	%ecx, %rax
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
               	addb	%al, 0x41(%rdx)
