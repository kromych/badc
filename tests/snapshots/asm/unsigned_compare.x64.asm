
unsigned_compare.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40040d <.text+0x14d>
               	movq	%rax, %rdi
               	callq	*0xfe19(%rip)           # 0x4100f0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfe06(%rip), %r9       # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40034b <.text+0x8b>
               	leaq	0xfde2(%rip), %rdi      # 0x410100
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%rdi, %r9
               	addq	%r8, %r9
               	movq	(%r9), %r8
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	-0x18(%rbp), %r9
               	xorq	%r12, %r12
               	leaq	0xfdbf(%rip), %rdi      # 0x410118
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfdad(%rip), %rsi      # 0x41011e
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfd9c(%rip), %r9       # 0x410125
               	movq	%r9, (%rsi)
               	leaq	-0x18(%rbp), %rdi
               	movq	%rbx, %r9
               	shlq	$0x3, %r9
               	movq	%rdi, %rsi
               	addq	%r9, %rsi
               	movq	(%rsi), %r14
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	xorl	%eax, %eax
               	callq	0x400977 <dlsym>
               	cmpq	$0x0, %rax
               	je	0x4003d9 <.text+0x119>
               	leaq	0xfd3f(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rax), %r12
               	movq	%r12, (%rdi)
               	jmp	0x4003d9 <.text+0x119>
               	leaq	0xfd20(%rip), %r12      # 0x410100
               	movq	%rbx, %rax
               	shlq	$0x3, %rax
               	movq	%r12, %rbx
               	addq	%rax, %rbx
               	movq	(%rbx), %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x90, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movl	$0x1, %ebx
               	movl	$0xfffffffe, %r12d      # imm = 0xFFFFFFFE
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rbx, %r8
               	movl	$0xffffffff, %edi       # imm = 0xFFFFFFFF
               	andq	%r12, %rdi
               	cmpq	%rdi, %r8
               	jbe	0x40048b <.text+0x1cb>
               	leaq	0xfcf9(%rip), %r14      # 0x410150
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x40097d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%r12, %r14
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	cmpq	%rax, %r14
               	seta	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4004ef <.text+0x22f>
               	leaq	0xfcb7(%rip), %r15      # 0x410172
               	movq	%r15, %rdi
               	movb	$0x0, %al
               	callq	0x40097d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ebx
               	movl	$0xfffffffe, %r15d      # imm = 0xFFFFFFFE
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%rbx, %r14
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r15, %r12
               	cmpq	%r12, %r14
               	jbe	0x400550 <.text+0x290>
               	leaq	0xfc78(%rip), %r14      # 0x410194
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x40097d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0xffffffff, %r14d      # imm = 0xFFFFFFFF
               	andq	%r15, %r14
               	movl	$0xffffffff, %eax       # imm = 0xFFFFFFFF
               	andq	%rbx, %rax
               	cmpq	%rax, %r14
               	seta	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4005b4 <.text+0x2f4>
               	leaq	0xfc37(%rip), %r12      # 0x4101b7
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x40097d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ebx
               	movabsq	$-0x2, %r12
               	cmpq	%r12, %rbx
               	jbe	0x400607 <.text+0x347>
               	leaq	0xfc07(%rip), %r15      # 0x4101da
               	movq	%r15, %rdi
               	movb	$0x0, %al
               	callq	0x40097d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	cmpq	%rbx, %r12
               	seta	%r15b
               	movzbq	%r15b, %r15
               	cmpq	$0x0, %r15
               	jne	0x40065a <.text+0x39a>
               	leaq	0xfbd6(%rip), %r14      # 0x4101fc
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x40097d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %r15d
               	movabsq	$-0x2, %r14
               	cmpq	%r14, %r15
               	jb	0x4006ae <.text+0x3ee>
               	leaq	0xfba4(%rip), %r12      # 0x41021e
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x40097d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	cmpq	%r15, %r14
               	setae	%r12b
               	movzbq	%r12b, %r12
               	cmpq	$0x0, %r12
               	jne	0x400701 <.text+0x441>
               	leaq	0xfb76(%rip), %rbx      # 0x410243
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	0x40097d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movl	$0xfe, %eax
               	movq	%rax, %r15
               	andq	$0xff, %r15
               	movq	%rbx, %rax
               	andq	$0xff, %rax
               	cmpq	%rax, %r15
               	jg	0x400761 <.text+0x4a1>
               	leaq	0xfb3b(%rip), %r12      # 0x410268
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x40097d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %ebx
               	movabsq	$-0x2, %r12
               	movslq	%ebx, %r15
               	movslq	%r12d, %r14
               	cmpq	%r14, %r15
               	setg	%al
               	movzbq	%al, %rax
               	cmpq	$0x0, %rax
               	jne	0x4007c9 <.text+0x509>
               	leaq	0xfaf2(%rip), %r15      # 0x410287
               	movq	%r15, %rdi
               	movb	$0x0, %al
               	callq	0x40097d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movslq	%ebx, %r15
               	movslq	%r12d, %rax
               	cmpq	%rax, %r15
               	jge	0x400813 <.text+0x553>
               	leaq	0xfabd(%rip), %r14      # 0x41029c
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x40097d <printf>
               	movslq	%eax, %rax
               	movl	$0x1, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
               	addb	%al, 0x41(%rdx)
