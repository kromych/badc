
glob_flags_and_results.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	subq	$0x1e0, %rsp            # imm = 0x1E0
               	pushq	%rbx
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x40, %esi
               	leaq	<rip>, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x1e0, %rsp            # imm = 0x1E0
               	retq
               	leaq	0x60(%rsp), %rdi
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	0x160(%rsp), %rdi
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	0x160(%rsp), %rdi
               	movl	$0x241, %esi            # imm = 0x241
               	movl	$0x180, %edx            # imm = 0x180
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rdi
               	testl	%edi, %edi
               	jge	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	addq	$0x1e0, %rsp            # imm = 0x1E0
               	retq
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0x160(%rsp), %rdi
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	0x160(%rsp), %rdi
               	movl	$0x241, %esi            # imm = 0x241
               	movl	$0x180, %edx            # imm = 0x180
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rax, %rdi
               	testl	%edi, %edi
               	jl	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	leaq	0x60(%rsp), %rdi
               	movl	$0x1c0, %esi            # imm = 0x1C0
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	0xe0(%rsp), %rdi
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	0xe0(%rsp), %rdi
               	xorl	%esi, %esi
               	xorl	%edx, %edx
               	leaq	0x18(%rsp), %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x2, %ebx
               	leaq	0xe0(%rsp), %rdi
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	0xe0(%rsp), %rdi
               	callq	<addr>
               	leaq	0xe0(%rsp), %rdi
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	0xe0(%rsp), %rdi
               	callq	<addr>
               	leaq	0x60(%rsp), %rdi
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rbx, %rax
               	popq	%rbx
               	addq	$0x1e0, %rsp            # imm = 0x1E0
               	retq
               	movq	0x18(%rsp), %rax
               	cmpq	$0x2, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	xorl	%eax, %eax
               	testq	%rcx, %rcx
               	je	<addr>
               	movq	0x20(%rsp), %rax
               	movq	(%rax), %rbx
               	leaq	0x160(%rsp), %rdi
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rbx, %rdi
               	leaq	0x160(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%ebx, %ebx
               	testq	%rax, %rax
               	je	<addr>
               	movq	0x20(%rsp), %rax
               	movq	0x8(%rax), %rbx
               	leaq	0x160(%rsp), %rdi
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rbx, %rdi
               	leaq	0x160(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x3, %ebx
               	jmp	<addr>
               	leaq	0xe0(%rsp), %rdi
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	0xe0(%rsp), %rdi
               	movl	$0x2, %esi
               	xorl	%edx, %edx
               	leaq	0x18(%rsp), %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x4, %ebx
               	jmp	<addr>
               	movq	0x18(%rsp), %rax
               	cmpq	$0x1, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%ebx, %ebx
               	testq	%rax, %rax
               	je	<addr>
               	movq	0x20(%rsp), %rax
               	movq	(%rax), %rbx
               	leaq	0x160(%rsp), %rdi
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rbx, %rdi
               	leaq	0x160(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0x5, %ebx
               	jmp	<addr>
               	leaq	0xe0(%rsp), %rdi
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	0xe0(%rsp), %rdi
               	xorl	%esi, %esi
               	xorl	%edx, %edx
               	leaq	0x18(%rsp), %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x6, %ebx
               	jmp	<addr>
               	leaq	0xe0(%rsp), %rdi
               	movl	$0x10, %esi
               	xorl	%edx, %edx
               	leaq	0x18(%rsp), %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movq	0x18(%rsp), %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movq	0x20(%rsp), %rax
               	movq	(%rax), %rdi
               	leaq	0xe0(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x7, %ebx
               	jmp	<addr>
               	leaq	0xe0(%rsp), %rdi
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	0xe0(%rsp), %rdi
               	movl	$0x20, %esi
               	xorl	%edx, %edx
               	leaq	0x18(%rsp), %rcx
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x8, %ebx
               	jmp	<addr>
               	movq	0x18(%rsp), %rax
               	cmpq	$0x2, %rax
               	sete	%al
               	movzbq	%al, %rax
               	xorl	%ebx, %ebx
               	testq	%rax, %rax
               	je	<addr>
               	movq	0x20(%rsp), %rax
               	movq	0x8(%rax), %rbx
               	leaq	0x160(%rsp), %rdi
               	movl	$0x80, %esi
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	movq	%rbx, %rdi
               	leaq	0x160(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	leaq	0x18(%rsp), %rdi
               	callq	<addr>
               	xorl	%eax, %eax
               	movl	$0x9, %ecx
               	testq	%rbx, %rbx
               	movq	%rcx, %rbx
               	cmovneq	%rax, %rbx
               	jmp	<addr>
