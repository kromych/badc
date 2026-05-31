
unsigned_compare.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400410 <.text+0x150>
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
               	callq	0x4009a7 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x4003dc <.text+0x11c>
               	leaq	0xfd3c(%rip), %r14      # 0x410100
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x4003dc <.text+0x11c>
               	leaq	0xfd1d(%rip), %r12      # 0x410100
               	movq	%rbx, %rsi
               	shlq	$0x3, %rsi
               	movq	%r12, %rbx
               	addq	%rsi, %rbx
               	movq	(%rbx), %rsi
               	movq	%rsi, %rcx
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
               	jbe	0x400491 <.text+0x1d1>
               	leaq	0xfcf6(%rip), %r14      # 0x410150
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x4009ad <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movl	$0x1, %esi
               	movq	%rsi, %rcx
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
               	movl	$0xffffffff, %esi       # imm = 0xFFFFFFFF
               	andq	%rbx, %rsi
               	cmpq	%rsi, %r14
               	seta	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4004f8 <.text+0x238>
               	leaq	0xfcb1(%rip), %r15      # 0x410172
               	movq	%r15, %rdi
               	movb	$0x0, %al
               	callq	0x4009ad <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rsi
               	movl	$0x1, %esi
               	movq	%rsi, %rcx
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
               	jbe	0x40055d <.text+0x29d>
               	leaq	0xfc6f(%rip), %r14      # 0x410194
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x4009ad <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
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
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%rbx, %r8
               	cmpq	%r8, %r14
               	seta	%bl
               	movzbq	%bl, %rbx
               	cmpq	$0x0, %rbx
               	jne	0x4005c6 <.text+0x306>
               	leaq	0xfc29(%rip), %r12      # 0x4101b7
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x4009ad <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r8
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
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
               	jbe	0x40061d <.text+0x35d>
               	leaq	0xfbf5(%rip), %r15      # 0x4101da
               	movq	%r15, %rdi
               	movb	$0x0, %al
               	callq	0x4009ad <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
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
               	jne	0x400674 <.text+0x3b4>
               	leaq	0xfbc0(%rip), %r14      # 0x4101fc
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x4009ad <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
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
               	jb	0x4006cb <.text+0x40b>
               	leaq	0xfb8a(%rip), %r12      # 0x41021e
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x4009ad <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
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
               	jne	0x400722 <.text+0x462>
               	leaq	0xfb59(%rip), %rbx      # 0x410243
               	movq	%rbx, %rdi
               	movb	$0x0, %al
               	callq	0x4009ad <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r14
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	xorq	%rbx, %rbx
               	movl	$0xfe, %r14d
               	movq	%r14, %r15
               	andq	$0xff, %r15
               	movq	%rbx, %r14
               	andq	$0xff, %r14
               	cmpq	%r14, %r15
               	jg	0x400786 <.text+0x4c6>
               	leaq	0xfb19(%rip), %r12      # 0x410268
               	movq	%r12, %rdi
               	movb	$0x0, %al
               	callq	0x4009ad <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movl	$0x1, %r14d
               	movabsq	$-0x2, %r12
               	movslq	%r14d, %r15
               	movslq	%r12d, %rbx
               	cmpq	%rbx, %r15
               	setg	%r8b
               	movzbq	%r8b, %r8
               	cmpq	$0x0, %r8
               	jne	0x4007f2 <.text+0x532>
               	leaq	0xfacc(%rip), %r15      # 0x410287
               	movq	%r15, %rdi
               	movb	$0x0, %al
               	callq	0x4009ad <printf>
               	movslq	%eax, %rax
               	movq	%rax, %rbx
               	movl	$0x1, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x90, %rsp
               	popq	%rbp
               	retq
               	movslq	%r14d, %r15
               	movslq	%r12d, %rbx
               	cmpq	%rbx, %r15
               	jge	0x400840 <.text+0x580>
               	leaq	0xfa94(%rip), %r14      # 0x41029c
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x4009ad <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	movl	$0x1, %r12d
               	movq	%r12, %rcx
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
