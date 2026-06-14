
c4.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$0x460, %esi            # imm = 0x460
               	callq	<addr>
               	ud2

<__c5_lazy_stream>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%rdi, %rbx
               	movslq	%ebx, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12,%rbx,8), %rax
               	testq	%rax, %rax
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
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x8(%rax)
               	leaq	-0x18(%rbp), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x10(%rax)
               	leaq	-0x18(%rbp), %rax
               	movq	(%rax,%rbx,8), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%rax), %rax
               	movq	%rax, (%r12,%rbx,8)
               	movq	(%r12,%rbx,8), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq

<next>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x160, %rsp            # imm = 0x160
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movsbq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x23, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	leaq	<rip>, %r12
               	movq	(%r12), %rcx
               	movq	%rax, %rdx
               	subq	%rcx, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	(%rbx), %rax
               	movq	%rax, (%r12)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rax
               	jge	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rbx)
               	movq	(%rcx), %rcx
               	leaq	(%rcx,%rcx,4), %rcx
               	movq	%rax, %rsi
               	addq	%rcx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	(%rbx), %rax
               	movq	(%rax), %rax
               	cmpq	$0x7, %rax
               	jg	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	(%rcx), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x61, %rax
               	setge	%al
               	movzbq	%al, %rax
               	xorq	%rbx, %rbx
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0xa, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7a, %rax
               	setle	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	movl	$0x1, %r12d
               	testq	%rbx, %rbx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x41, %rax
               	setge	%al
               	movzbq	%al, %rax
               	xorq	%rbx, %rbx
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	testq	%r12, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5a, %rax
               	setle	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	setne	%r12b
               	movzbq	%r12b, %r12
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5f, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rbx
               	decq	%rbx
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x30, %rax
               	setge	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x61, %rax
               	setge	%al
               	movzbq	%al, %rax
               	xorq	%r12, %r12
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	imulq	$0x93, %rcx, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rdi
               	incq	%rdi
               	movq	%rdi, (%rdx)
               	movsbq	(%rsi), %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	shlq	$0x6, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	subq	%rbx, %rdx
               	addq	%rdx, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x7a, %rax
               	setle	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movl	$0x1, %r14d
               	testq	%r12, %r12
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x41, %rax
               	setge	%al
               	movzbq	%al, %rax
               	xorq	%r12, %r12
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %r12d
               	testq	%r14, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x5a, %rax
               	setle	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	setne	%r14b
               	movzbq	%r14b, %r14
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x30, %rax
               	setge	%al
               	movzbq	%al, %rax
               	xorq	%r12, %r12
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	testq	%r12, %r12
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x39, %rax
               	setle	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	setne	%r12b
               	movzbq	%r12b, %r12
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x5f, %rax
               	sete	%r12b
               	movzbq	%r12b, %r12
               	testq	%r12, %r12
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	0x8(%rcx), %rcx
               	cmpq	%rcx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	%rbx, 0x10(%rcx)
               	movq	(%rax), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, 0x8(%rcx)
               	movq	(%rax), %rax
               	xorq	%rcx, %rcx
               	movl	$0x85, %esi
               	movq	%rsi, (%rax)
               	movq	%rsi, (%rdx)
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x10(%rax), %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, %rdx
               	subq	%rbx, %rdx
               	movq	%rbx, %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	xorq	%rdx, %rdx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	movq	%rdx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x48, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x39, %rax
               	setle	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	subq	$0x30, %rcx
               	movq	%rcx, (%rax)
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2f, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x80, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x78, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x30, %rax
               	setge	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	imulq	$0xa, %rcx, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rdi
               	incq	%rdi
               	movq	%rdi, (%rdx)
               	movsbq	(%rsi), %rdx
               	addq	%rdx, %rcx
               	subq	$0x30, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x39, %rax
               	setle	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x58, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	incq	%rdx
               	movq	%rdx, (%rcx)
               	movsbq	(%rdx), %rcx
               	movq	%rcx, (%rax)
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	shlq	$0x4, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rdi
               	andq	$0xf, %rdi
               	addq	%rdi, %rcx
               	cmpq	$0x41, %rsi
               	jl	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x30, %rax
               	setge	%al
               	movzbq	%al, %rax
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x39, %rax
               	setle	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %esi
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x61, %rax
               	setge	%al
               	movzbq	%al, %rax
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %ecx
               	testq	%rsi, %rsi
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x66, %rax
               	setle	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	setne	%sil
               	movzbq	%sil, %rsi
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x41, %rax
               	setge	%al
               	movzbq	%al, %rax
               	xorq	%rdx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x46, %rax
               	setle	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	setne	%cl
               	movzbq	%cl, %rcx
               	jmp	<addr>
               	movl	$0x9, %esi
               	jmp	<addr>
               	xorq	%rsi, %rsi
               	addq	%rsi, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x30, %rax
               	setge	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	shlq	$0x3, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rdi
               	incq	%rdi
               	movq	%rdi, (%rdx)
               	movsbq	(%rsi), %rdx
               	addq	%rdx, %rcx
               	subq	$0x30, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x37, %rax
               	setle	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x2f, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x27, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0xa0, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0xa, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x22, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3d, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movsbq	(%rcx), %rcx
               	testq	%rcx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rdi
               	incq	%rdi
               	movq	%rdi, (%rdx)
               	movsbq	(%rsi), %rdx
               	movq	%rdx, (%rcx)
               	cmpq	$0x5c, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	incq	%rdx
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x22, %rcx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movsbq	(%rcx), %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rdx
               	cmpq	%rdx, %rcx
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rdx
               	movq	(%rdx), %rsi
               	movq	%rsi, %rdi
               	incq	%rdi
               	movq	%rdi, (%rdx)
               	movsbq	(%rsi), %rdx
               	movq	%rdx, (%rcx)
               	cmpq	$0x6e, %rdx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	cmpq	$0x22, %rcx
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movl	$0xa, %edx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movq	%rdx, %rsi
               	incq	%rsi
               	movq	%rsi, (%rcx)
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movb	%cl, (%rdx)
               	jmp	<addr>
               	leaq	<rip>, %rcx
               	movq	%rax, (%rcx)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x80, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x3d, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2b, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x95, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x8e, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x2b, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2d, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0xa2, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x9d, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x2d, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x21, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0xa3, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x9e, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x3d, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3c, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x96, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x3d, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3e, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x99, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x3c, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x9b, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x97, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x3d, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7c, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x9a, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x3e, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x9c, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x98, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x7c, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x26, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x90, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x92, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x26, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5e, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	incq	%rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x91, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movl	$0x94, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movl	$0x93, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x25, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	$0xa1, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2a, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	$0x9f, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5b, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	$0xa4, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3f, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movl	$0x8f, %ecx
               	movq	%rcx, (%rax)
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7e, %rax
               	sete	%al
               	movzbq	%al, %rax
               	movl	$0x1, %edx
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7d, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x28, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	movl	$0x1, %ecx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x5d, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%cl
               	movzbq	%cl, %rcx
               	movl	$0x1, %edx
               	testq	%rcx, %rcx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3a, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x160, %rsp            # imm = 0x160
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<expr>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0xf0, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %rbx
               	leaq	<rip>, %r12
               	movq	(%r12), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x80, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %r14d
               	movq	%r14, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	%r14, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x22, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, (%rcx)
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x8c, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x22, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	andq	$-0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x2, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	callq	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x85, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	movq	(%r12), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x86, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	xorq	%rcx, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x2, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	movq	%rcx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0x1, %ecx
               	jmp	<addr>
               	movl	$0x8, %ecx
               	movq	%rcx, (%r14)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r14
               	callq	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	xorq	%r15, %r15
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x18(%r14), %rax
               	cmpq	$0x80, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x29, %rax
               	je	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %eax
               	movq	%rax, (%rcx)
               	incq	%r15
               	movq	(%r12), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	movq	0x18(%r14), %rax
               	cmpq	$0x82, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	0x28(%r14), %rax
               	movq	%rax, (%rcx)
               	testq	%r15, %r15
               	je	<addr>
               	jmp	<addr>
               	movq	0x18(%r14), %rax
               	cmpq	$0x81, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x3, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	0x28(%r14), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x7, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	%r15, (%rcx)
               	leaq	<rip>, %rax
               	movq	0x20(%r14), %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	0x28(%r14), %rax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	%rdx, (%rax)
               	jmp	<addr>
               	movq	0x18(%r14), %rax
               	cmpq	$0x84, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	xorq	%rdx, %rdx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x28(%r14), %rdx
               	subq	%rdx, %rax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	leaq	<rip>, %rax
               	movq	0x20(%r14), %rcx
               	movq	%rcx, (%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	jmp	<addr>
               	movq	0x18(%r14), %rax
               	cmpq	$0x83, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	0x28(%r14), %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0xa, %ecx
               	jmp	<addr>
               	movl	$0x9, %ecx
               	movq	%rcx, (%r15)
               	jmp	<addr>
               	callq	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x8a, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x86, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	je	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x1, %r14d
               	jmp	<addr>
               	xorq	%r14, %r14
               	callq	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	addq	$0x2, %r14
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	%r14, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x1, %rax
               	jle	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x94, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	subq	$0x2, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0xa, %ecx
               	jmp	<addr>
               	movl	$0x9, %ecx
               	movq	%rcx, (%r14)
               	jmp	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x21, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$-0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x2, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	xorq	%rsi, %rsi
               	movq	%rsi, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x11, %eax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	%rdx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x7e, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movabsq	$-0x1, %rsi
               	movq	%rsi, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xf, %eax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	%rdx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9d, %rax
               	jne	<addr>
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9e, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %eax
               	movq	%rax, (%rcx)
               	movq	(%r12), %rax
               	cmpq	$0x80, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0xa2, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	imulq	$-0x1, %rax, %rax
               	movq	%rax, (%rcx)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movabsq	$-0x1, %rcx
               	movq	%rcx, (%rax)
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x1b, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0xa3, %rax
               	sete	%r14b
               	movzbq	%r14b, %r14
               	testq	%r14, %r14
               	je	<addr>
               	movq	(%r12), %r14
               	callq	<addr>
               	movl	$0xa2, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xa, %eax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	movq	%rcx, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2, %rax
               	jle	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x9, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0x8, %ecx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, (%r15)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	cmpq	$0xa2, %r14
               	jne	<addr>
               	movl	$0x19, %edx
               	jmp	<addr>
               	movl	$0x1a, %edx
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %edx
               	jmp	<addr>
               	movl	$0xb, %edx
               	movq	%rdx, (%rcx)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	%rbx, %rax
               	jl	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %r14
               	movq	(%r12), %rax
               	cmpq	$0x8e, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0xf0, %rsp
               	popq	%rbp
               	retq
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	sete	%r15b
               	movzbq	%r15b, %r15
               	testq	%r15, %r15
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x8f, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	sete	%r15b
               	movzbq	%r15b, %r15
               	testq	%r15, %r15
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	%rcx, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	leaq	<rip>, %rax
               	movq	%r14, (%rax)
               	testq	%r14, %r14
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0xc, %ecx
               	jmp	<addr>
               	movl	$0xb, %ecx
               	movq	%rcx, (%r15)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x4, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	movq	%rcx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x3a, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x90, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %r15
               	movq	(%r15), %rax
               	addq	$0x18, %rax
               	movq	%rax, (%r14)
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	movl	$0x2, %ecx
               	movq	%rcx, (%rax)
               	movq	(%r15), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%r15)
               	movl	$0x8f, %edi
               	callq	<addr>
               	movq	(%r15), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x5, %ecx
               	movq	%rcx, (%rax)
               	movq	(%r14), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0x91, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x91, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x4, %ecx
               	movq	%rcx, (%rax)
               	movq	(%r14), %rax
               	movq	%rax, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%r14)
               	movl	$0x92, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r15)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x92, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x93, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xe, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x93, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x94, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xf, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x94, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x95, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x10, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x95, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x97, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x11, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x96, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x97, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x12, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x97, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x13, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x98, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x14, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x99, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x15, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9a, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x9b, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x16, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9b, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x9d, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x17, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9c, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0x9d, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x18, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9d, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %eax
               	movq	%rax, (%rcx)
               	movl	$0x9f, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	%r14, (%rax)
               	cmpq	$0x2, %r14
               	jle	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9e, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x8, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1b, %eax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x19, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %eax
               	movq	%rax, (%rcx)
               	movl	$0x9f, %edi
               	callq	<addr>
               	cmpq	$0x2, %r14
               	setg	%r15b
               	movzbq	%r15b, %r15
               	testq	%r15, %r15
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	%rax, %r14
               	sete	%r15b
               	movzbq	%r15b, %r15
               	testq	%r15, %r15
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1a, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x8, %esi
               	movq	%rsi, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1c, %eax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	%rdx, (%rax)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	%r14, (%rax)
               	cmpq	$0x2, %r14
               	jle	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x8, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1b, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1a, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1a, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x1b, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0xa0, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x1c, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0xa1, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %r14
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movl	$0xa2, %edi
               	callq	<addr>
               	movq	(%r14), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movl	$0x1d, %ecx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0xa2, %rax
               	sete	%r15b
               	movzbq	%r15b, %r15
               	testq	%r15, %r15
               	jne	<addr>
               	movq	(%r12), %rax
               	cmpq	$0xa3, %rax
               	sete	%r15b
               	movzbq	%r15b, %r15
               	testq	%r15, %r15
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0xa, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%r12), %rax
               	cmpq	$0xa4, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xa, %eax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	movq	%rcx, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2, %rax
               	jle	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x9, %eax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0x8, %ecx
               	jmp	<addr>
               	movl	$0x1, %ecx
               	movq	%rcx, (%r14)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	(%r12), %rax
               	cmpq	$0xa2, %rax
               	jne	<addr>
               	movl	$0x19, %edx
               	jmp	<addr>
               	movl	$0x1a, %edx
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	movl	$0xc, %edx
               	jmp	<addr>
               	movl	$0xb, %edx
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2, %rax
               	jle	<addr>
               	movl	$0x8, %edx
               	jmp	<addr>
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movq	(%r12), %rax
               	cmpq	$0xa2, %rax
               	jne	<addr>
               	movl	$0x1a, %edx
               	jmp	<addr>
               	movl	$0x19, %edx
               	movq	%rdx, (%rcx)
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %eax
               	movq	%rax, (%rcx)
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	(%r12), %rax
               	cmpq	$0x5d, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movq	(%r12), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	cmpq	$0x2, %r14
               	jle	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0xd, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x8, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x1b, %eax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x19, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	movq	%rcx, %r15
               	addq	$0x8, %r15
               	movq	%r15, (%rax)
               	leaq	<rip>, %rax
               	movq	%r14, %rcx
               	subq	$0x2, %rcx
               	movq	%rcx, (%rax)
               	testq	%rcx, %rcx
               	jne	<addr>
               	jmp	<addr>
               	cmpq	$0x2, %r14
               	jge	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movl	$0xa, %ecx
               	jmp	<addr>
               	movl	$0x9, %ecx
               	movq	%rcx, (%r15)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>

<stmt>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x40, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	cmpq	$0x89, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x40, %rsp
               	popq	%rbp
               	retq
               	movq	(%rbx), %rax
               	cmpq	$0x8d, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x4, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	movq	%rcx, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x87, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x18, %rcx
               	movq	%rcx, (%r12)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x2, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	movq	%rcx, %r12
               	addq	$0x8, %r12
               	movq	%r12, (%rax)
               	callq	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r12)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, %r12
               	addq	$0x8, %r12
               	movq	(%rbx), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x8b, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x29, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rbx
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movl	$0x4, %ecx
               	movq	%rcx, (%rax)
               	movq	(%rbx), %rax
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	%r14, (%rbx)
               	callq	<addr>
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movl	$0x2, %ecx
               	movq	%rcx, (%rax)
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rbx)
               	movq	%r12, (%rax)
               	movq	(%rbx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x3b, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x7b, %rax
               	jne	<addr>
               	jmp	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x8, %eax
               	movq	%rax, (%rcx)
               	movq	(%rbx), %rax
               	cmpq	$0x3b, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x3b, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x7d, %rax
               	je	<addr>
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	movl	$0x8e, %edi
               	callq	<addr>
               	movq	(%rbx), %rax
               	cmpq	$0x3b, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x1d0, %rsp            # imm = 0x1D0
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%rdi, %r12
               	decq	%r12
               	movq	%rsi, %r14
               	addq	$0x8, %r14
               	testq	%r12, %r12
               	setg	%al
               	movzbq	%al, %rax
               	xorq	%rbx, %rbx
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%r14), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x2d, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	(%r14), %rax
               	movsbq	0x1(%rax), %rax
               	cmpq	$0x73, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	decq	%r12
               	addq	$0x8, %r14
               	testq	%r12, %r12
               	setg	%al
               	movzbq	%al, %rax
               	xorq	%rbx, %rbx
               	testq	%rax, %rax
               	je	<addr>
               	movq	(%r14), %rax
               	movsbq	(%rax), %rax
               	cmpq	$0x2d, %rax
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	setne	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	movq	(%r14), %rax
               	movsbq	0x1(%rax), %rax
               	cmpq	$0x64, %rax
               	sete	%bl
               	movzbq	%bl, %rbx
               	testq	%rbx, %rbx
               	je	<addr>
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	decq	%r12
               	addq	$0x8, %r14
               	cmpq	$0x1, %r12
               	jge	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	movq	(%r14), %rdi
               	xorq	%rsi, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	testq	%rbx, %rbx
               	jge	<addr>
               	leaq	<rip>, %rdi
               	movq	(%r14), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	movl	$0x40000, %r15d         # imm = 0x40000
               	leaq	<rip>, %r10
               	movq	%r10, 0xe8(%rsp)
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0xe8(%rsp), %r10
               	movq	%rax, (%r10)
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	<rip>, %r10
               	movq	%r10, 0xe0(%rsp)
               	leaq	<rip>, %r10
               	movq	%r10, 0xd8(%rsp)
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0xd8(%rsp), %r10
               	movq	%rax, (%r10)
               	movq	0xe0(%rsp), %r10
               	movq	%rax, (%r10)
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	<rip>, %r10
               	movq	%r10, 0xd0(%rsp)
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0xd0(%rsp), %r10
               	movq	%rax, (%r10)
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r10
               	movq	%r10, 0xc8(%rsp)
               	movq	0xc8(%rsp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	xorq	%r10, %r10
               	movq	%r10, 0xc0(%rsp)
               	movq	%r15, %rdx
               	movq	0xc0(%rsp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movq	%r15, %rdx
               	movq	0xc0(%rsp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rdi
               	movq	%r15, %rdx
               	movq	0xc0(%rsp), %rsi
               	xorl	%eax, %eax
               	callq	<addr>
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x86, %r10d
               	movq	%r10, 0xb8(%rsp)
               	movq	0xb8(%rsp), %rax
               	cmpq	$0x8d, %rax
               	jg	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0xb8(%rsp), %rcx
               	incq	%rcx
               	movq	0xb8(%rsp), %r13
               	movq	%r13, (%rax)
               	movq	%rcx, 0xb8(%rsp)
               	jmp	<addr>
               	movl	$0x1e, %r10d
               	movq	%r10, 0xb0(%rsp)
               	movq	0xb0(%rsp), %rax
               	cmpq	$0x26, %rax
               	jg	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movl	$0x82, %edx
               	movq	%rdx, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movl	$0x1, %edx
               	movq	%rdx, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	0xb0(%rsp), %rcx
               	incq	%rcx
               	movq	0xb0(%rsp), %r13
               	movq	%r13, 0x28(%rax)
               	movq	%rcx, 0xb0(%rsp)
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %r10
               	movq	%r10, 0xa8(%rsp)
               	movq	0xa8(%rsp), %r10
               	movq	(%r10), %rax
               	movl	$0x86, %ecx
               	movq	%rcx, (%rax)
               	callq	<addr>
               	movq	0xa8(%rsp), %r10
               	movq	(%r10), %r10
               	movq	%r10, 0xa0(%rsp)
               	leaq	<rip>, %r10
               	movq	%r10, 0x98(%rsp)
               	leaq	<rip>, %r10
               	movq	%r10, 0x90(%rsp)
               	movq	%r15, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	0x90(%rsp), %r10
               	movq	%rax, (%r10)
               	movq	0x98(%rsp), %r10
               	movq	%rax, (%r10)
               	testq	%rax, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	%r15, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movq	%r15, %rdx
               	decq	%rdx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r10
               	movq	%r10, 0x88(%rsp)
               	movq	0x88(%rsp), %rax
               	testq	%rax, %rax
               	jg	<addr>
               	leaq	<rip>, %rdi
               	movq	0x88(%rsp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	addq	0x88(%rsp), %rax
               	xorq	%rcx, %rcx
               	movb	%cl, (%rax)
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	leaq	<rip>, %rax
               	movl	$0x1, %ecx
               	movq	%rcx, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	movl	$0x1, %ebx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	0xa0(%rsp), %r10
               	movq	0x28(%r10), %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x30(%rsp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x86, %rax
               	jne	<addr>
               	callq	<addr>
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x88, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	jne	<addr>
               	callq	<addr>
               	xorq	%r10, %r10
               	movq	%r10, 0x80(%rsp)
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7d, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x85, %rax
               	je	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8e, %rax
               	jne	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x80, %rax
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movl	$0x80, %edx
               	movq	%rdx, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movl	$0x1, %edx
               	movq	%rdx, 0x20(%rcx)
               	movq	(%rax), %rax
               	movq	0x78(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x80(%rsp)
               	movq	0x78(%rsp), %r13
               	movq	%r13, 0x28(%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %r10
               	movq	%r10, 0x78(%rsp)
               	callq	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b, %rax
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x70(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	jmp	<addr>
               	movq	%rbx, 0x68(%rsp)
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7d, %rax
               	setne	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x70(%rsp)
               	movq	0x70(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	0x68(%rsp), %r10
               	addq	$0x2, %r10
               	movq	%r10, 0x68(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x85, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x18(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x68(%rsp), %r13
               	movq	%r13, 0x20(%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x28, %rax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movl	$0x81, %edx
               	movq	%rdx, 0x18(%rcx)
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, 0x28(%rax)
               	callq	<addr>
               	xorq	%r10, %r10
               	movq	%r10, 0x60(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movl	$0x83, %edx
               	movq	%rdx, 0x18(%rcx)
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rdx
               	movq	%rdx, 0x28(%rax)
               	movq	(%rcx), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x29, %rax
               	je	<addr>
               	movl	$0x1, %r10d
               	movq	%r10, 0x58(%rsp)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	jmp	<addr>
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7b, %rax
               	je	<addr>
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x86, %rax
               	jne	<addr>
               	callq	<addr>
               	xorq	%r10, %r10
               	movq	%r10, 0x58(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	0x58(%rsp), %r10
               	addq	$0x2, %r10
               	movq	%r10, 0x58(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x85, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x84, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x30(%rcx)
               	movq	(%rax), %rcx
               	movl	$0x84, %edx
               	movq	%rdx, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x38(%rcx)
               	movq	(%rax), %rcx
               	movq	0x58(%rsp), %r13
               	movq	%r13, 0x20(%rcx)
               	movq	(%rax), %rcx
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x40(%rcx)
               	movq	(%rax), %rax
               	movq	0x60(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x50(%rsp)
               	movq	0x60(%rsp), %r13
               	movq	%r13, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	0x50(%rsp), %r13
               	movq	%r13, 0x60(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	0x60(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r13
               	movq	%r13, (%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	testq	%r10, %r10
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x8a, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x6, %edx
               	movq	%rdx, (%rcx)
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	%rax, %r10
               	movq	0x48(%rsp), %rax
               	subq	%r10, %rax
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x86, %rax
               	sete	%r10b
               	movzbq	%r10b, %r10
               	movq	%r10, 0x40(%rsp)
               	movq	0x40(%rsp), %r10
               	testq	%r10, %r10
               	je	<addr>
               	jmp	<addr>
               	movl	$0x1, %ebx
               	jmp	<addr>
               	xorq	%rbx, %rbx
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x3b, %rax
               	je	<addr>
               	movq	%rbx, 0x38(%rsp)
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x9f, %rax
               	jne	<addr>
               	callq	<addr>
               	movq	0x38(%rsp), %r10
               	addq	$0x2, %r10
               	movq	%r10, 0x38(%rsp)
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x85, %rax
               	je	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x84, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	(%rax), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x18(%rcx), %rdx
               	movq	%rdx, 0x30(%rcx)
               	movq	(%rax), %rcx
               	movl	$0x84, %edx
               	movq	%rdx, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	0x20(%rcx), %rdx
               	movq	%rdx, 0x38(%rcx)
               	movq	(%rax), %rcx
               	movq	0x38(%rsp), %r13
               	movq	%r13, 0x20(%rcx)
               	movq	(%rax), %rcx
               	movq	0x28(%rcx), %rdx
               	movq	%rdx, 0x40(%rcx)
               	movq	(%rax), %rax
               	movq	0x48(%rsp), %r10
               	incq	%r10
               	movq	%r10, 0x48(%rsp)
               	movq	0x48(%rsp), %r13
               	movq	%r13, 0x28(%rax)
               	callq	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x2c, %rax
               	jne	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	cmpq	$0x7d, %rax
               	je	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x8, %rcx
               	movq	%rcx, (%rax)
               	movl	$0x8, %eax
               	movq	%rax, (%rcx)
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	movq	%rcx, (%rax)
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	movq	0x18(%rax), %rax
               	cmpq	$0x84, %rax
               	jne	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	movq	0x30(%rcx), %rdx
               	movq	%rdx, 0x18(%rcx)
               	movq	(%rax), %rcx
               	movq	0x38(%rcx), %rdx
               	movq	%rdx, 0x20(%rcx)
               	movq	(%rax), %rcx
               	movq	0x40(%rcx), %rax
               	movq	%rax, 0x28(%rcx)
               	leaq	<rip>, %rax
               	movq	(%rax), %rcx
               	addq	$0x48, %rcx
               	movq	%rcx, (%rax)
               	jmp	<addr>
               	callq	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	movq	%r15, %r10
               	movq	0xc8(%rsp), %r15
               	addq	%r10, %r15
               	movq	%r15, %rax
               	addq	$-0x8, %rax
               	movl	$0x26, %ecx
               	movq	%rcx, (%rax)
               	addq	$-0x8, %rax
               	movl	$0xd, %ecx
               	movq	%rcx, (%rax)
               	movq	%rax, %rcx
               	addq	$-0x8, %rcx
               	movq	%r12, (%rcx)
               	addq	$-0x8, %rcx
               	movq	%r14, (%rcx)
               	movq	%rcx, %r14
               	addq	$-0x8, %r14
               	movq	%rax, (%r14)
               	xorq	%rbx, %rbx
               	movq	0x30(%rsp), %r10
               	addq	$0x8, %r10
               	movq	%r10, 0x28(%rsp)
               	movq	0x30(%rsp), %r10
               	movq	(%r10), %r10
               	movq	%r10, 0x20(%rsp)
               	incq	%rbx
               	leaq	<rip>, %rax
               	movq	(%rax), %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	leaq	<rip>, %rax
               	movq	0x20(%rsp), %rcx
               	leaq	(%rcx,%rcx,4), %rcx
               	movq	%rax, %rdx
               	addq	%rcx, %rdx
               	movq	%rbx, %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	0x20(%rsp), %rax
               	cmpq	$0x7, %rax
               	jg	<addr>
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	testq	%rax, %rax
               	jne	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	0x28(%rsp), %r10
               	movq	(%r10), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movq	0x28(%rsp), %r10
               	addq	$0x8, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x28(%rsp), %r10
               	movq	(%r10), %rax
               	shlq	$0x3, %rax
               	movq	%r15, %r12
               	addq	%rax, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x1, %rax
               	jne	<addr>
               	movq	0x28(%rsp), %r10
               	addq	$0x8, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x28(%rsp), %r10
               	movq	(%r10), %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x2, %rax
               	jne	<addr>
               	movq	0x28(%rsp), %r10
               	movq	(%r10), %r10
               	movq	%r10, 0x30(%rsp)
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x3, %rax
               	jne	<addr>
               	addq	$-0x8, %r14
               	movq	0x28(%rsp), %rax
               	addq	$0x8, %rax
               	movq	%rax, (%r14)
               	movq	0x28(%rsp), %r10
               	movq	(%r10), %r10
               	movq	%r10, 0x30(%rsp)
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x4, %rax
               	jne	<addr>
               	movq	-0x48(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x5, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	0x28(%rsp), %r10
               	addq	$0x8, %r10
               	movq	%r10, 0x30(%rsp)
               	jmp	<addr>
               	movq	0x28(%rsp), %r10
               	movq	(%r10), %r10
               	movq	%r10, 0x30(%rsp)
               	jmp	<addr>
               	movq	-0x48(%rbp), %rax
               	testq	%rax, %rax
               	je	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x6, %rax
               	jne	<addr>
               	jmp	<addr>
               	movq	0x28(%rsp), %r10
               	movq	(%r10), %r10
               	movq	%r10, 0x30(%rsp)
               	jmp	<addr>
               	movq	0x28(%rsp), %r10
               	addq	$0x8, %r10
               	movq	%r10, 0x30(%rsp)
               	jmp	<addr>
               	movq	%r14, %rax
               	addq	$-0x8, %rax
               	movq	%r15, (%rax)
               	movq	0x28(%rsp), %r10
               	addq	$0x8, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x28(%rsp), %r10
               	movq	(%r10), %rcx
               	shlq	$0x3, %rcx
               	movq	%rax, %r14
               	subq	%rcx, %r14
               	movq	%rax, %r15
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x7, %rax
               	jne	<addr>
               	movq	0x28(%rsp), %r10
               	addq	$0x8, %r10
               	movq	%r10, 0x30(%rsp)
               	movq	0x28(%rsp), %r10
               	movq	(%r10), %rax
               	shlq	$0x3, %rax
               	addq	%rax, %r14
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x8, %rax
               	jne	<addr>
               	movq	%r15, %rax
               	addq	$0x8, %rax
               	movq	(%r15), %r15
               	movq	%rax, %r14
               	addq	$0x8, %r14
               	movq	(%rax), %r10
               	movq	%r10, 0x30(%rsp)
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	-0x48(%rbp), %rax
               	movq	(%rax), %r12
               	movq	%r12, -0x48(%rbp)
               	movq	0x28(%rsp), %r13
               	movq	%r13, 0x30(%rsp)
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0xa, %rax
               	jne	<addr>
               	movq	-0x48(%rbp), %rax
               	movsbq	(%rax), %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0xb, %rax
               	jne	<addr>
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	(%r14), %rcx
               	movq	-0x48(%rbp), %rdx
               	movq	%rdx, (%rcx)
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0xc, %rax
               	jne	<addr>
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	(%r14), %rcx
               	movq	-0x48(%rbp), %r12
               	movb	%r12b, (%rcx)
               	movq	%r12, -0x48(%rbp)
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0xd, %rax
               	jne	<addr>
               	addq	$-0x8, %r14
               	movq	-0x48(%rbp), %rax
               	movq	%rax, (%r14)
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0xe, %rax
               	jne	<addr>
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	(%r14), %rcx
               	movq	-0x48(%rbp), %rdx
               	movq	%rcx, %r12
               	orq	%rdx, %r12
               	movq	%r12, -0x48(%rbp)
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0xf, %rax
               	jne	<addr>
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	(%r14), %rcx
               	movq	-0x48(%rbp), %rdx
               	movq	%rcx, %r12
               	xorq	%rdx, %r12
               	movq	%r12, -0x48(%rbp)
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x10, %rax
               	jne	<addr>
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	(%r14), %rcx
               	movq	-0x48(%rbp), %rdx
               	movq	%rcx, %r12
               	andq	%rdx, %r12
               	movq	%r12, -0x48(%rbp)
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x11, %rax
               	jne	<addr>
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	(%r14), %rcx
               	movq	-0x48(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	sete	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x12, %rax
               	jne	<addr>
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	(%r14), %rcx
               	movq	-0x48(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	setne	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x13, %rax
               	jne	<addr>
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	(%r14), %rcx
               	movq	-0x48(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	setl	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x14, %rax
               	jne	<addr>
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	(%r14), %rcx
               	movq	-0x48(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	setg	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x15, %rax
               	jne	<addr>
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	(%r14), %rcx
               	movq	-0x48(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	setle	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x16, %rax
               	jne	<addr>
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	(%r14), %rcx
               	movq	-0x48(%rbp), %rdx
               	cmpq	%rdx, %rcx
               	setge	%r12b
               	movzbq	%r12b, %r12
               	movq	%r12, -0x48(%rbp)
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x17, %rax
               	jne	<addr>
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	(%r14), %rcx
               	movq	-0x48(%rbp), %rdx
               	movq	%rcx, %r12
               	movq	%rdx, %rcx
               	shlq	%cl, %r12
               	movq	%r12, -0x48(%rbp)
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x18, %rax
               	jne	<addr>
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	(%r14), %rcx
               	movq	-0x48(%rbp), %rdx
               	movq	%rcx, %r12
               	movq	%rdx, %rcx
               	sarq	%cl, %r12
               	movq	%r12, -0x48(%rbp)
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x19, %rax
               	jne	<addr>
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	(%r14), %rcx
               	movq	-0x48(%rbp), %rdx
               	movq	%rcx, %r12
               	addq	%rdx, %r12
               	movq	%r12, -0x48(%rbp)
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x1a, %rax
               	jne	<addr>
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	(%r14), %rcx
               	movq	-0x48(%rbp), %rdx
               	movq	%rcx, %r12
               	subq	%rdx, %r12
               	movq	%r12, -0x48(%rbp)
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x1b, %rax
               	jne	<addr>
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	(%r14), %rcx
               	movq	-0x48(%rbp), %rdx
               	movq	%rcx, %r12
               	imulq	%rdx, %r12
               	movq	%r12, -0x48(%rbp)
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x1c, %rax
               	jne	<addr>
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	(%r14), %rcx
               	movq	-0x48(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rax, %r12
               	popq	%rdx
               	popq	%rax
               	movq	%r12, -0x48(%rbp)
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x1d, %rax
               	jne	<addr>
               	movq	%r14, %rax
               	addq	$0x8, %rax
               	movq	(%r14), %rcx
               	movq	-0x48(%rbp), %rdx
               	movq	%rdx, %r10
               	pushq	%rax
               	pushq	%rdx
               	movq	%rcx, %rax
               	cqto
               	idivq	%r10
               	movq	%rdx, %r12
               	popq	%rdx
               	popq	%rax
               	movq	%r12, -0x48(%rbp)
               	movq	%rax, %r14
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x1e, %rax
               	jne	<addr>
               	movq	0x8(%r14), %rdi
               	movq	(%r14), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x1f, %rax
               	jne	<addr>
               	movq	0x10(%r14), %rdi
               	movq	0x8(%r14), %rsi
               	movq	(%r14), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x20, %rax
               	jne	<addr>
               	movq	(%r14), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x21, %rax
               	jne	<addr>
               	movq	0x28(%rsp), %r10
               	movq	0x8(%r10), %rax
               	shlq	$0x3, %rax
               	addq	%r14, %rax
               	movq	%rax, %rcx
               	addq	$-0x8, %rcx
               	movq	(%rcx), %rdi
               	movq	%rax, %rcx
               	addq	$-0x10, %rcx
               	movq	(%rcx), %rsi
               	movq	%rax, %rcx
               	addq	$-0x18, %rcx
               	movq	(%rcx), %rdx
               	movq	%rax, %rcx
               	addq	$-0x20, %rcx
               	movq	(%rcx), %rcx
               	movq	%rax, %r8
               	addq	$-0x28, %r8
               	movq	(%r8), %r8
               	addq	$-0x30, %rax
               	movq	(%rax), %r9
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x22, %rax
               	jne	<addr>
               	movq	(%r14), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x23, %rax
               	jne	<addr>
               	movq	(%r14), %rdi
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x24, %rax
               	jne	<addr>
               	movq	0x10(%r14), %rdi
               	movq	0x8(%r14), %rsi
               	movq	(%r14), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x25, %rax
               	jne	<addr>
               	movq	0x10(%r14), %rdi
               	movq	0x8(%r14), %rsi
               	movq	(%r14), %rdx
               	xorl	%eax, %eax
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movq	%r12, -0x48(%rbp)
               	jmp	<addr>
               	movq	0x20(%rsp), %rax
               	cmpq	$0x26, %rax
               	jne	<addr>
               	leaq	<rip>, %rdi
               	movq	(%r14), %rsi
               	movq	%rbx, %rdx
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movq	(%r14), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	jmp	<addr>
               	leaq	<rip>, %rdi
               	movq	%rbx, %rdx
               	movq	0x20(%rsp), %rsi
               	movb	$0x0, %al
               	callq	<addr>
               	movslq	%eax, %rax
               	movabsq	$-0x1, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x1d0, %rsp            # imm = 0x1D0
               	popq	%rbp
               	retq
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	movq	0x80(%rsp), %r13
               	movq	%r13, 0x78(%rsp)
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
               	jmp	<addr>
