
thread_local_per_thread.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	0x400390 <.text+0xa0>
               	movq	%rax, %rdi
               	callq	*0xfde9(%rip)           # 0x4100f0
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, %r11
               	movq	%fs:0x0, %r11
               	subq	$0x8, %r11
               	movslq	(%r11), %r9
               	cmpq	$0x0, %r9
               	je	0x400335 <.text+0x45>
               	movl	$0xbad1, %eax           # imm = 0xBAD1
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %r9
               	subq	$0x8, %r9
               	movl	$0x63, %eax
               	movl	%eax, (%r9)
               	movq	%fs:0x0, %r8
               	subq	$0x8, %r8
               	movslq	(%r8), %rax
               	cmpq	$0x63, %rax
               	je	0x400378 <.text+0x88>
               	movl	$0xbad2, %r8d           # imm = 0xBAD2
               	movq	%r8, %rax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	subq	$0x8, %rax
               	movslq	(%rax), %r8
               	movq	%r8, %rax
               	popq	%rbp
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x80, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r14, 0x10(%rsp)
               	movq	%r15, 0x18(%rsp)
               	movq	%fs:0x0, %r11
               	subq	$0x8, %r11
               	movl	$0x1, %r9d
               	movl	%r9d, (%r11)
               	xorq	%rbx, %rbx
               	movl	$0x2, %r12d
               	movq	%rbx, %rdi
               	movq	%r12, %rsi
               	xorl	%eax, %eax
               	callq	0x400627 <dlopen>
               	movq	%rax, %r14
               	leaq	0xfd21(%rip), %r15      # 0x410108
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x40062d <dlsym>
               	movq	%rax, %r10
               	movq	%r10, 0x28(%rsp)
               	leaq	0xfd14(%rip), %r15      # 0x410117
               	movq	%r14, %rdi
               	movq	%r15, %rsi
               	xorl	%eax, %eax
               	callq	0x40062d <dlsym>
               	movq	%rax, %r12
               	leaq	-0x20(%rbp), %r14
               	leaq	-0x117(%rip), %r15      # 0x400307 <.text+0x17>
               	movq	0x28(%rsp), %r11
               	movq	%r14, %rdi
               	movq	%rbx, %rcx
               	movq	%r15, %rdx
               	movq	%rbx, %rsi
               	callq	*%r11
               	movq	-0x20(%rbp), %rbx
               	leaq	-0x28(%rbp), %r14
               	movq	%r12, %r11
               	movq	%rbx, %rdi
               	movq	%r14, %rsi
               	callq	*%r11
               	movq	-0x28(%rbp), %rax
               	cmpq	$0x63, %rax
               	je	0x40047f <.text+0x18f>
               	movl	$0x1, %r14d
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rax
               	subq	$0x8, %rax
               	movslq	(%rax), %r14
               	cmpq	$0x1, %r14
               	je	0x4004c6 <.text+0x1d6>
               	movl	$0x2, %eax
               	movq	%rax, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
               	xorq	%r14, %r14
               	movq	%r14, %rcx
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r14
               	movq	0x18(%rsp), %r15
               	movq	%rcx, %rax
               	addq	$0x80, %rsp
               	popq	%rbp
               	retq
