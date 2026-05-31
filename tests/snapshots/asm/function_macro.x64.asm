
function_macro.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x40059a <.text+0x37a>
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
               	je	0x400314 <.text+0xf4>
               	jmp	0x4002f0 <.text+0xd0>
               	leaq	0x10(%rbp), %r8
               	movq	(%r8), %r9
               	movq	%r9, %r11
               	addq	$0x1, %r11
               	movq	%r11, (%r8)
               	leaq	0x20(%rbp), %r9
               	movq	(%r9), %r11
               	movq	%r11, %r8
               	addq	$0x1, %r8
               	movq	%r8, (%r9)
               	jmp	0x40026f <.text+0x4f>
               	movq	0x10(%rbp), %r8
               	movzbq	(%r8), %r11
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	sete	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x10(%rbp)
               	cmpq	$0x0, %r11
               	je	0x400353 <.text+0x133>
               	jmp	0x40032a <.text+0x10a>
               	movq	0x10(%rbp), %r9
               	movzbq	(%r9), %r11
               	movq	0x20(%rbp), %r9
               	movzbq	(%r9), %r8
               	cmpq	%r8, %r11
               	sete	%r9b
               	movzbq	%r9b, %r9
               	movq	%r9, -0x8(%rbp)
               	jmp	0x400314 <.text+0xf4>
               	movq	-0x8(%rbp), %r9
               	cmpq	$0x0, %r9
               	je	0x4002ba <.text+0x9a>
               	jmp	0x40028d <.text+0x6d>
               	movq	0x20(%rbp), %r8
               	movzbq	(%r8), %r11
               	movl	$0xffffffff, %r8d       # imm = 0xFFFFFFFF
               	andq	%r11, %r8
               	cmpq	$0x0, %r8
               	sete	%r11b
               	movzbq	%r11b, %r11
               	movq	%r11, -0x10(%rbp)
               	jmp	0x400353 <.text+0x133>
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
               	leaq	0xfd40(%rip), %rbx      # 0x4100d0
               	leaq	0xfd44(%rip), %r12      # 0x4100db
               	leaq	0xfd48(%rip), %r14      # 0x4100e6
               	leaq	0xfd4c(%rip), %r15      # 0x4100f1
               	movq	%rbx, %rdi
               	movq	%r15, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	jne	0x4003e7 <.text+0x1c7>
               	movl	$0x15, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfd0e(%rip), %r15      # 0x4100fc
               	movq	%r12, %rdi
               	movq	%r15, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	jne	0x400430 <.text+0x210>
               	movl	$0x16, %esi
               	movq	%rsi, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfcd0(%rip), %r15      # 0x410107
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %rsi
               	cmpq	$0x0, %rsi
               	jne	0x400479 <.text+0x259>
               	movl	$0x17, %esi
               	movq	%rsi, %rcx
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
               	movq	%rax, %r15
               	cmpq	$0x0, %r15
               	jne	0x4004bc <.text+0x29c>
               	movl	$0x18, %r15d
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
               	movq	%r14, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r12
               	cmpq	$0x0, %r12
               	jne	0x4004ff <.text+0x2df>
               	movl	$0x19, %r12d
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x50, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rcx
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
               	leaq	0xfbd3(%rip), %rbx      # 0x410112
               	leaq	0xfbd7(%rip), %r12      # 0x41011d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r8
               	cmpq	$0x0, %r8
               	jne	0x40057f <.text+0x35f>
               	movl	$0x1f, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%r12, %r12
               	movq	%r12, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	%rcx, %rax
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	callq	0x40036b <.text+0x14b>
               	movq	%rax, %r11
               	movslq	%r11d, %r9
               	cmpq	$0x0, %r9
               	je	0x4005eb <.text+0x3cb>
               	movslq	%r11d, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	callq	0x400524 <.text+0x304>
               	movq	%rax, %r8
               	movslq	%r8d, %rbx
               	cmpq	$0x0, %rbx
               	je	0x400623 <.text+0x403>
               	movslq	%r8d, %rbx
               	movq	%rbx, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	leaq	0xfafe(%rip), %r12      # 0x410128
               	leaq	0xfafc(%rip), %r14      # 0x41012d
               	movq	%r12, %rdi
               	movq	%r14, %rsi
               	callq	0x400237 <.text+0x17>
               	movq	%rax, %r8
               	cmpq	$0x0, %r8
               	jne	0x40066f <.text+0x44f>
               	movl	$0x29, %r8d
               	movq	%r8, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	%rcx, %rax
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
