
glob_flags_and_results.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1d8, %rsp            # imm = 0x1D8
               	pushq	%rbx
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	leaq	-0x180(%rbp), %rdi
               	leaq	<rip>, %r8
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %r8
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x241, %esi            # imm = 0x241
               	movl	$0x180, %edx            # imm = 0x180
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rdi
               	testl	%edi, %edi
               	jge	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	<rip>, %r8
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x241, %esi            # imm = 0x241
               	movl	$0x180, %edx            # imm = 0x180
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rdi
               	testl	%edi, %edi
               	jl	<addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	-0x180(%rbp), %rdi
               	movl	$0x1c0, %esi            # imm = 0x1C0
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	-0x100(%rbp), %rdi
               	leaq	<rip>, %r8
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-0x1c8(%rbp), %rcx
               	movq	%rsi, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %ebx
               	leaq	-0x100(%rbp), %rdi
               	leaq	<rip>, %r8
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	leaq	<rip>, %r8
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	-0x180(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	leave
               	retq
               	movq	-0x1c8(%rbp), %rax
               	cmpq	$0x2, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	-0x1c0(%rbp), %rax
               	movq	(%rax), %rbx
               	leaq	<rip>, %r8
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x80(%rbp), %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%ebx, %ebx
               	testq	%rax, %rax
               	je	<addr>
               	movq	-0x1c0(%rbp), %rax
               	movq	0x8(%rax), %rbx
               	leaq	<rip>, %r8
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x80(%rbp), %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	leaq	-0x1c8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x3, %ebx
               	jmp	<addr>
               	leaq	-0x100(%rbp), %rdi
               	leaq	<rip>, %r8
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x2, %esi
               	xorl	%edx, %edx
               	leaq	-0x1c8(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %ebx
               	jmp	<addr>
               	movq	-0x1c8(%rbp), %rax
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%ebx, %ebx
               	testq	%rax, %rax
               	je	<addr>
               	movq	-0x1c0(%rbp), %rax
               	movq	(%rax), %rbx
               	leaq	<rip>, %r8
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x80(%rbp), %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	leaq	-0x1c8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x5, %ebx
               	jmp	<addr>
               	leaq	-0x100(%rbp), %rdi
               	leaq	<rip>, %r8
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	xorl	%esi, %esi
               	leaq	-0x1c8(%rbp), %rcx
               	movq	%rsi, %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x6, %ebx
               	jmp	<addr>
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x10, %esi
               	xorl	%edx, %edx
               	leaq	-0x1c8(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	-0x1c8(%rbp), %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movq	-0x1c0(%rbp), %rax
               	movq	(%rax), %rdi
               	leaq	-0x100(%rbp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %ebx
               	jmp	<addr>
               	leaq	-0x100(%rbp), %rdi
               	leaq	<rip>, %r8
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x100(%rbp), %rdi
               	movl	$0x20, %esi
               	xorl	%edx, %edx
               	leaq	-0x1c8(%rbp), %rcx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %ebx
               	jmp	<addr>
               	movq	-0x1c8(%rbp), %rax
               	cmpq	$0x2, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%ebx, %ebx
               	testq	%rax, %rax
               	je	<addr>
               	movq	-0x1c0(%rbp), %rax
               	movq	0x8(%rax), %rbx
               	leaq	<rip>, %r8
               	leaq	-0x80(%rbp), %rdi
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	-0x80(%rbp), %rsi
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	leaq	-0x1c8(%rbp), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	$0x9, %ecx
               	testq	%rbx, %rbx
               	movq	%rcx, %rbx
               	cmovneq	%rax, %rbx
               	jmp	<addr>
