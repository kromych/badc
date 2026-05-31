
function_macro.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400585 <.text+0x365>
               	movq	%rax, %rdi
               	callq	*0xfe89(%rip)           # 0x4100c0
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rsi, (%rsp)
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rdi, %r11
               	movq	%r11, 0x10(%rbp)
               	movq	%rsi, %r9
               	movq	%r9, 0x20(%rbp)
               	jmp	0x40026f <.text+0x4f>
               	movq	0x10(%rbp), %r9
               	movzbq	(%r9), %r11
               	movq	%r11, -0x8(%rbp)
               	cmpq	$0x0, %r11
               	je	0x40030e <.text+0xee>
               	jmp	0x4002ea <.text+0xca>
               	leaq	0x10(%rbp), %r8
               	movq	(%r8), %r11
               	addq	$0x1, %r11
               	movq	%r11, (%r8)
               	leaq	0x20(%rbp), %r9
               	movq	(%r9), %r11
               	addq	$0x1, %r11
               	movq	%r11, (%r9)
               	jmp	0x40026f <.text+0x4f>
               	movq	0x10(%rbp), %r11
               	movzbq	(%r11), %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	sete	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x10(%rbp)
               	cmpq	$0x0, %r8
               	je	0x40034d <.text+0x12d>
               	jmp	0x400324 <.text+0x104>
               	movq	0x10(%rbp), %r9
               	movzbq	(%r9), %r11
               	movq	0x20(%rbp), %r9
               	movzbq	(%r9), %r8
               	cmpq	%r8, %r11
               	sete	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x8(%rbp)
               	jmp	0x40030e <.text+0xee>
               	movq	-0x8(%rbp), %r11
               	cmpq	$0x0, %r11
               	je	0x4002b4 <.text+0x94>
               	jmp	0x40028d <.text+0x6d>
               	movq	0x20(%rbp), %r11
               	movzbq	(%r11), %r8
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	sete	%r8b
               	movzbq	%r8b, %r8
               	movq	%r8, -0x10(%rbp)
               	jmp	0x40034d <.text+0x12d>
               	movq	-0x10(%rbp), %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	popq	%r11
               	addq	$0x20, %rsp
               	pushq	%r11
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x50, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	leaq	0xfd46(%rip), %rbx      # 0x4100d0
               	leaq	0xfd4a(%rip), %r12      # 0x4100db
               	leaq	0xfd4e(%rip), %r14      # 0x4100e6
               	leaq	0xfd52(%rip), %r15      # 0x4100f1
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x0, %rax
               	jne	0x4003df <.text+0x1bf>
               	movl	$0x15, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd16(%rip), %r15      # 0x4100fc
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x0, %rax
               	jne	0x400426 <.text+0x206>
               	movl	$0x16, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfcda(%rip), %r15      # 0x410107
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x0, %rax
               	jne	0x40046d <.text+0x24d>
               	movl	$0x17, %r15d
               	movq	%r15, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x0, %rax
               	jne	0x4004ad <.text+0x28d>
               	movl	$0x18, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x0, %rax
               	jne	0x4004ed <.text+0x2cd>
               	movl	$0x19, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	0xfbe5(%rip), %rbx      # 0x410112
               	leaq	0xfbe9(%rip), %r12      # 0x41011d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x0, %rax
               	jne	0x40056a <.text+0x34a>
               	movl	$0x1f, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	callq	0x400365 <.text+0x145>
               	movslq	%eax, %r9
               	cmpq	$0x0, %r9
               	je	0x4005c9 <.text+0x3a9>
               	movslq	%eax, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	callq	0x400512 <.text+0x2f2>
               	movslq	%eax, %rbx
               	cmpq	$0x0, %rbx
               	je	0x4005f9 <.text+0x3d9>
               	movslq	%eax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfb28(%rip), %r12      # 0x410128
               	leaq	0xfb26(%rip), %rbx      # 0x41012d
               	movq	%r12, %rdi
               	movq	%rbx, %rsi
               	callq	0x400237 <.text+0x17>
               	cmpq	$0x0, %rax
               	jne	0x40063c <.text+0x41c>
               	movl	$0x29, %ebx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
