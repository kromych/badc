
static_init_cast_funcptr.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400470 <.text+0x170>
               	movq	%rax, %rdi
               	callq	*0xfde1(%rip)           # 0x4100f8
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movslq	%edi, %rbx
               	leaq	0xfdce(%rip), %r9       # 0x410108
               	movq	%rbx, %r8
               	shlq	$0x3, %r8
               	movq	%r9, %rdi
               	addq	%r8, %rdi
               	movq	(%rdi), %r8
               	cmpq	$0x0, %r8
               	je	0x40038b <.text+0x8b>
               	leaq	0xfdaa(%rip), %rdi      # 0x410108
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
               	leaq	0xfd87(%rip), %rdi      # 0x410120
               	movq	%rdi, (%r9)
               	leaq	-0x18(%rbp), %rsi
               	movq	%rsi, %rdi
               	addq	$0x8, %rdi
               	leaq	0xfd75(%rip), %rsi      # 0x410126
               	movq	%rsi, (%rdi)
               	leaq	-0x18(%rbp), %r9
               	movq	%r9, %rsi
               	addq	$0x10, %rsi
               	leaq	0xfd64(%rip), %r9       # 0x41012d
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
               	callq	0x400887 <dlsym>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	je	0x40041c <.text+0x11c>
               	leaq	0xfd04(%rip), %r14      # 0x410108
               	movq	%rbx, %r12
               	shlq	$0x3, %r12
               	movq	%r14, %rdi
               	addq	%r12, %rdi
               	movq	(%rsi), %r12
               	movq	%r12, (%rdi)
               	jmp	0x40041c <.text+0x11c>
               	leaq	0xfce5(%rip), %r12      # 0x410108
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
               	movslq	%edi, %r11
               	movq	%r11, %r9
               	shlq	$0x1, %r9
               	movslq	%r9d, %rax
               	retq
               	movslq	%edi, %r11
               	movabsq	$-0x1, %rax
               	imulq	%r11, %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xfcc3(%rip), %r11      # 0x410158
               	movq	%r11, %r9
               	addq	$0x8, %r9
               	movq	(%r9), %rbx
               	movl	$0x15, %r12d
               	movq	%rbx, %r11
               	movq	%r12, %rdi
               	callq	*%r11
               	movq	%rax, %r8
               	cmpq	$0x2a, %r8
               	je	0x4004e9 <.text+0x1e9>
               	movl	$0x1, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc68(%rip), %r12      # 0x410158
               	movq	%r12, %r8
               	addq	$0x20, %r8
               	movq	(%r8), %r14
               	movl	$0x7, %r12d
               	movq	%r14, %r11
               	movq	%r12, %rdi
               	callq	*%r11
               	movq	%rax, %rbx
               	cmpq	$-0x7, %rbx
               	je	0x400543 <.text+0x243>
               	movl	$0x2, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfc0e(%rip), %r12      # 0x410158
               	movq	%r12, %rbx
               	addq	$0x10, %rbx
               	movq	(%rbx), %r15
               	leaq	0xfc3a(%rip), %r12      # 0x410198
               	movq	%r15, %r11
               	movq	%r12, %rdi
               	callq	*%r11
               	movq	%rax, %r14
               	cmpq	$0x64, %r14
               	je	0x40059f <.text+0x29f>
               	movl	$0x3, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfbb2(%rip), %r12      # 0x410158
               	movq	%r12, %r14
               	addq	$0x28, %r14
               	movq	(%r14), %rbx
               	leaq	0xfbe2(%rip), %r12      # 0x41019c
               	movq	%rbx, %r11
               	movq	%r12, %rdi
               	callq	*%r11
               	movq	%rax, %r15
               	cmpq	$-0x11, %r15
               	je	0x4005fb <.text+0x2fb>
               	movl	$0x4, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb56(%rip), %r12      # 0x410158
               	movq	(%r12), %r15
               	movzbq	(%r15), %r12
               	movq	%r12, %r15
               	xorq	$0x64, %r15
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r15, %r12
               	cmpq	$0x0, %r12
               	je	0x400652 <.text+0x352>
               	movl	$0x5, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfaff(%rip), %r15      # 0x410158
               	movq	%r15, %r12
               	addq	$0x18, %r12
               	movq	(%r12), %r15
               	movzbq	(%r15), %r12
               	movq	%r12, %r15
               	xorq	$0x6e, %r15
               	movl	$0xffffffff, %r12d      # imm = 0xFFFFFFFF
               	andq	%r15, %r12
               	cmpq	$0x0, %r12
               	je	0x4006b3 <.text+0x3b3>
               	movl	$0x6, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfae6(%rip), %r14      # 0x4101a0
               	movq	%r14, %rdi
               	movb	$0x0, %al
               	callq	0x40088d <printf>
               	movslq	%eax, %rax
               	movq	%rax, %r12
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	0x10(%rbp), %rbx
               	movq	%rbx, %rdi
               	xorl	%eax, %eax
               	callq	0x400893 <atoi>
               	movslq	%eax, %rax
               	movq	%rax, %r9
               	movq	%r9, %rcx
               	movq	(%rsp), %rbx
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq
