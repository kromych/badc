
dirent_stream.x64:	file format elf64-x86-64

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
               	subq	$0x128, %rsp            # imm = 0x128
               	pushq	%r14
               	pushq	%r13
               	pushq	%r12
               	pushq	%rbx
               	subq	$0x10, %rsp
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	leaq	<rip>, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	leaq	<rip>, %r12
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x11, %eax
               	jne	<addr>
               	nopw	%cs:(%rax,%rax)
               	cmpl	$0x3e8, %ebx            # imm = 0x3E8
               	je	<addr>
               	incq	%rbx
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r13
               	xorl	%edi, %edi
               	nopl	(%rax)
               	callq	<addr>
               	movq	%rax, %r9
               	movq	%rbx, (%rsp)
               	movq	%r12, %rcx
               	movq	%r13, %r8
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x200, %esi            # imm = 0x200
               	leaq	<rip>, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x1c0, %esi            # imm = 0x1C0
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x2, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x128, %rsp            # imm = 0x128
               	retq
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	testq	%rdi, %rdi
               	jne	<addr>
               	movl	$0x3, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x128, %rsp            # imm = 0x128
               	retq
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rax, %r13
               	testq	%r13, %r13
               	jne	<addr>
               	movl	$0x4, %ebx
               	callq	<addr>
               	movl	$0x0, (%rax)
               	testl	%ebx, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0xb, %ebx
               	callq	<addr>
               	movl	$0x0, (%rax)
               	testl	%ebx, %ebx
               	jne	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	(%rax), %eax
               	cmpl	$0x14, %eax
               	je	<addr>
               	movl	$0xc, %ebx
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x258, %esi            # imm = 0x258
               	leaq	<rip>, %rdx
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %r8
               	movb	$0x0, %al
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	leaq	<rip>, %rdi # <addr>
               	callq	<addr>
               	movq	%rbx, %rax
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x128, %rsp            # imm = 0x128
               	retq
               	xorl	%ebx, %ebx
               	movq	%rbx, %r14
               	jmp	<addr>
               	incq	%r14
               	leaq	0x13(%r12), %rdi
               	leaq	<rip>, %rsi
               	nopl	(%rax,%rax)
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rbx, %rcx
               	orq	$0x1, %rcx
               	testq	%rax, %rax
               	cmoveq	%rcx, %rbx
               	leaq	0x13(%r12), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rbx, %rcx
               	orq	$0x2, %rcx
               	testq	%rax, %rax
               	cmoveq	%rcx, %rbx
               	leaq	0x13(%r12), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rbx, %rcx
               	orq	$0x4, %rcx
               	testq	%rax, %rax
               	cmoveq	%rcx, %rbx
               	leaq	0x13(%r12), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rbx, %rcx
               	orq	$0x8, %rcx
               	testq	%rax, %rax
               	cmoveq	%rcx, %rbx
               	movq	%r13, %rdi
               	nop
               	callq	<addr>
               	movq	%rax, %r12
               	testq	%r12, %r12
               	jne	<addr>
               	cmpl	$0x4, %r14d
               	jne	<addr>
               	cmpl	$0xf, %ebx
               	je	<addr>
               	movl	$0x5, %ebx
               	movq	%r13, %rdi
               	callq	<addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	xorl	%r12d, %r12d
               	movq	%r12, 0x38(%rsp)
               	jmp	<addr>
               	addq	$0x1, 0x38(%rsp)
               	leaq	0x13(%r14), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%r12, %rcx
               	orq	$0x1, %rcx
               	testq	%rax, %rax
               	cmoveq	%rcx, %r12
               	leaq	0x13(%r14), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%r12, %rcx
               	orq	$0x2, %rcx
               	testq	%rax, %rax
               	cmoveq	%rcx, %r12
               	leaq	0x13(%r14), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%r12, %rcx
               	orq	$0x4, %rcx
               	testq	%rax, %rax
               	cmoveq	%rcx, %r12
               	leaq	0x13(%r14), %rdi
               	leaq	<rip>, %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%r12, %rcx
               	orq	$0x8, %rcx
               	testq	%rax, %rax
               	cmoveq	%rcx, %r12
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	nopw	(%rax,%rax)
               	testq	%r14, %r14
               	jne	<addr>
               	movq	0x38(%rsp), %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	cmpl	$0xf, %r12d
               	je	<addr>
               	movl	$0x6, %ebx
               	movq	%r13, %rdi
               	callq	<addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	testq	%r14, %r14
               	jne	<addr>
               	movl	$0x7, %ebx
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, %r12
               	testl	%ebx, %ebx
               	jne	<addr>
               	movq	%r13, %rdi
               	callq	<addr>
               	movq	%rax, %r14
               	testq	%r14, %r14
               	jne	<addr>
               	movl	$0x8, %ebx
               	movq	%r13, %rdi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	movl	$0xa, %ebx
               	jmp	<addr>
               	testl	%ebx, %ebx
               	jne	<addr>
               	leaq	0x13(%r14), %rsi
               	leaq	0x48(%rsp), %rdi
               	callq	<addr>
               	movq	%r13, %rdi
               	movq	%r12, %rsi
               	callq	<addr>
               	movq	%r13, %rdi
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	leaq	0x13(%rax), %rdi
               	leaq	0x48(%rsp), %rsi
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x9, %ebx
               	jmp	<addr>
               	xorl	%ebx, %ebx
               	jmp	<addr>
               	movl	$0x1, %eax
               	addq	$0x10, %rsp
               	popq	%rbx
               	popq	%r12
               	popq	%r13
               	popq	%r14
               	addq	$0x128, %rsp            # imm = 0x128
               	retq
