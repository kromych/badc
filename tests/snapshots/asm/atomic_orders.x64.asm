
atomic_orders.x64:	file format elf64-x86-64

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

<int_ops>:
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rdi
               	lock
               	xaddl	%edi, (%rax)
               	cmpl	$0xfffeee90, %edi       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %edi # <addr>
               	cmpl	$0xfffeee93, %edi       # imm = 0xFFFEEE93
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddl	%ecx, (%rax)
               	cmpl	$0xfffeee90, %ecx       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee8d, %eax       # imm = 0xFFFEEE8D
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	$0x6, %edi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee96, %eax       # imm = 0xFFFEEE96
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	$0x6, %edi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee96, %eax       # imm = 0xFFFEEE96
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	$0x9, %eax
               	xchgl	%eax, (%rcx)
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rdi
               	lock
               	xaddl	%edi, (%rax)
               	addq	$0x3, %rdi
               	cmpl	$0xfffeee93, %edi       # imm = 0xFFFEEE93
               	jne	<addr>
               	movl	<rip>, %edi # <addr>
               	cmpl	$0xfffeee93, %edi       # imm = 0xFFFEEE93
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddl	%ecx, (%rax)
               	leaq	-0x3(%rcx), %rax
               	cmpl	$0xfffeee8d, %eax       # imm = 0xFFFEEE8D
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee8d, %eax       # imm = 0xFFFEEE8D
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	$0x6, %ecx
               	movl	(%rdx), %eax
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	lock
               	cmpxchgl	%r10d, (%rdx)
               	jne	<addr>
               	andq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	(%rdx), %eax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgl	%r10d, (%rdx)
               	jne	<addr>
               	orq	%rcx, %rax
               	cmpl	$0xfffeee96, %eax       # imm = 0xFFFEEE96
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee96, %eax       # imm = 0xFFFEEE96
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	$0x6, %edi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	xorq	%rdi, %rax
               	cmpl	$0xfffeee96, %eax       # imm = 0xFFFEEE96
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee96, %eax       # imm = 0xFFFEEE96
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %r10
               	lock
               	xaddl	%r10d, (%rcx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddl	%r10d, (%rcx)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee92, %eax       # imm = 0xFFFEEE92
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	$0xe, %r9d
               	lock
               	andl	%r9d, (%rcx)
               	lock
               	orl	%edi, (%rcx)
               	lock
               	xorl	%edx, (%rcx)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgl	%r10d, (%rcx)
               	leaq	<rip>, %rdi # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movq	$-0x11170, %rcx         # imm = 0xFFFEEE90
               	movl	%ecx, <rip> # <addr>
               	movl	$0x9, %edx
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edx, (%rdi)
               	movl	$0xfffeee90, %r11d      # imm = 0xFFFEEE90
               	movq	%rax, %rdi
               	cmpl	%r11d, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rcx, %rax
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	<rip>, %edi # <addr>
               	cmpl	$0x9, %edi
               	jne	<addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	%ecx, <rip> # <addr>
               	movq	$-0x1116f, %rcx         # imm = 0xFFFEEE91
               	leaq	<rip>, %rdi # <addr>
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edx, (%rdi)
               	movl	$0xfffeee91, %r11d      # imm = 0xFFFEEE91
               	movq	%rax, %rdx
               	cmpl	%r11d, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rcx, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0xfffeee90, %edx       # imm = 0xFFFEEE90
               	jne	<addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x9, %r8d
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%r8d, (%rdi)
               	movl	$0xfffeee91, %r11d      # imm = 0xFFFEEE91
               	movq	%rax, %r8
               	cmpl	%r11d, %eax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	cmpl	$0xfffeee90, %ecx       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movl	$0xfffeee90, <rip> # imm = 0xFFFEEE90
                                                # <addr>
               	movq	$-0x11170, %rcx         # imm = 0xFFFEEE90
               	movl	$0x9, %edx
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edx, (%rdi)
               	movl	$0xfffeee90, %r11d      # imm = 0xFFFEEE90
               	movq	%rax, %rdi
               	cmpl	%r11d, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	%ecx, <rip> # <addr>
               	movq	$-0x1116f, %rcx         # imm = 0xFFFEEE91
               	movl	%ecx, <rip> # <addr>
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edx, (%rdi)
               	movl	$0xfffeee91, %r11d      # imm = 0xFFFEEE91
               	movq	%rax, %rdx
               	cmpl	%r11d, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movq	$-0x11170, %rdx         # imm = 0xFFFEEE90
               	movl	%edx, (%rdi)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %esi
               	cmpl	$0xfffeee90, %esi       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	%ecx, (%rax)
               	movl	(%rax), %ecx
               	cmpl	$0xfffeee91, %ecx       # imm = 0xFFFEEE91
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	(%rax), %ecx
               	cmpl	$0xfffeee91, %ecx       # imm = 0xFFFEEE91
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movq	%rdx, %r10
               	xchgl	%r10d, (%rax)
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %eax
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddl	%edx, (%rcx)
               	cmpl	$0xfffeee90, %edx       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %edx # <addr>
               	cmpl	$0xfffeee93, %edx       # imm = 0xFFFEEE93
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	negq	%rax
               	lock
               	xaddl	%eax, (%rcx)
               	subq	$0x3, %rax
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0x6, %edx
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee96, %eax       # imm = 0xFFFEEE96
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movq	$-0x11170, %rcx         # imm = 0xFFFEEE90
               	movl	%ecx, <rip> # <addr>
               	movl	$0x9, %esi
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%esi, (%rdx)
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0x8, %edi
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edi, (%rdx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movq	$-0x11170, %rdx         # imm = 0xFFFEEE90
               	movl	%esi, %eax
               	lock
               	cmpxchgl	%edx, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0x9, %eax
               	movl	%eax, %eax
               	lock
               	cmpxchgl	%edi, (%rcx)
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	movl	$0x7, %eax
               	xchgl	%eax, (%rcx)
               	cmpl	$0xfffeee90, %eax       # imm = 0xFFFEEE90
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movl	%eax, (%rcx)
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8e, %eax
               	retq
               	retq
               	movl	%eax, (%rsi)
               	jmp	<addr>
               	movl	%eax, (%rsi)
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<llong_ops>:
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movl	$0x9, %eax
               	xchgq	%rax, (%rdx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	addq	$0x3, %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	leaq	-0x3(%rdx), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, <rip> # <addr>
               	movl	$0x6, %edx
               	movq	(%rsi), %rax
               	movq	%rax, %r10
               	andq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rsi)
               	jne	<addr>
               	andq	%rdx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdi, <rip> # <addr>
               	movq	(%rsi), %rax
               	movq	%rax, %r10
               	orq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rsi)
               	jne	<addr>
               	orq	%rdx, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	xorq	%rdi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movl	$0x3, %esi
               	movq	%rsi, %r10
               	lock
               	xaddq	%r10, (%rdx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddq	%r10, (%rdx)
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fe, %r11     # imm = 0xFFFFFFFED5FA0E02
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %r8      # imm = 0xFFFFFFFED5FA0E00
               	movq	%r8, <rip> # <addr>
               	movl	$0xe, %r9d
               	lock
               	andq	%r9, (%rdx)
               	lock
               	orq	%rdi, (%rdx)
               	lock
               	xorq	%rsi, (%rdx)
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%r8, <rip> # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgq	%r10, (%rdx)
               	leaq	<rip>, %rax # <addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	$0x5, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movl	$0x9, %eax
               	xchgq	%rax, (%rdx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	addq	$0x3, %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	leaq	-0x3(%rdx), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, <rip> # <addr>
               	movl	$0x6, %edx
               	movq	(%rsi), %rax
               	movq	%rax, %r10
               	andq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rsi)
               	jne	<addr>
               	andq	%rdx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdi, <rip> # <addr>
               	movq	(%rsi), %rax
               	movq	%rax, %r10
               	orq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rsi)
               	jne	<addr>
               	orq	%rdx, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	xorq	%rdi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movl	$0x3, %esi
               	movq	%rsi, %r10
               	lock
               	xaddq	%r10, (%rdx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddq	%r10, (%rdx)
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fe, %r11     # imm = 0xFFFFFFFED5FA0E02
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %r8      # imm = 0xFFFFFFFED5FA0E00
               	movq	%r8, <rip> # <addr>
               	movl	$0xe, %r9d
               	lock
               	andq	%r9, (%rdx)
               	lock
               	orq	%rdi, (%rdx)
               	lock
               	xorq	%rsi, (%rdx)
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%r8, <rip> # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgq	%r10, (%rdx)
               	leaq	<rip>, %rax # <addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	$0x5, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movl	$0x9, %eax
               	xchgq	%rax, (%rdx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	addq	$0x3, %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	leaq	-0x3(%rdx), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, <rip> # <addr>
               	movl	$0x6, %edx
               	movq	(%rsi), %rax
               	movq	%rax, %r10
               	andq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rsi)
               	jne	<addr>
               	andq	%rdx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdi, <rip> # <addr>
               	movq	(%rsi), %rax
               	movq	%rax, %r10
               	orq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rsi)
               	jne	<addr>
               	orq	%rdx, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	xorq	%rdi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movl	$0x3, %esi
               	movq	%rsi, %r10
               	lock
               	xaddq	%r10, (%rdx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddq	%r10, (%rdx)
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fe, %r11     # imm = 0xFFFFFFFED5FA0E02
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %r8      # imm = 0xFFFFFFFED5FA0E00
               	movq	%r8, <rip> # <addr>
               	movl	$0xe, %r9d
               	lock
               	andq	%r9, (%rdx)
               	lock
               	orq	%rdi, (%rdx)
               	lock
               	xorq	%rsi, (%rdx)
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%r8, <rip> # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgq	%r10, (%rdx)
               	leaq	<rip>, %rax # <addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	$0x5, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movl	$0x9, %eax
               	xchgq	%rax, (%rdx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	addq	$0x3, %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	leaq	-0x3(%rdx), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, <rip> # <addr>
               	movl	$0x6, %edx
               	movq	(%rsi), %rax
               	movq	%rax, %r10
               	andq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rsi)
               	jne	<addr>
               	andq	%rdx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdi, <rip> # <addr>
               	movq	(%rsi), %rax
               	movq	%rax, %r10
               	orq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rsi)
               	jne	<addr>
               	orq	%rdx, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	xorq	%rdi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movl	$0x3, %esi
               	movq	%rsi, %r10
               	lock
               	xaddq	%r10, (%rdx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddq	%r10, (%rdx)
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fe, %r11     # imm = 0xFFFFFFFED5FA0E02
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %r8      # imm = 0xFFFFFFFED5FA0E00
               	movq	%r8, <rip> # <addr>
               	movl	$0xe, %r9d
               	lock
               	andq	%r9, (%rdx)
               	lock
               	orq	%rdi, (%rdx)
               	lock
               	xorq	%rsi, (%rdx)
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%r8, <rip> # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgq	%r10, (%rdx)
               	leaq	<rip>, %rax # <addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	$0x5, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movl	$0x9, %eax
               	xchgq	%rax, (%rdx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	addq	$0x3, %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	leaq	-0x3(%rdx), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, <rip> # <addr>
               	movl	$0x6, %edx
               	movq	(%rsi), %rax
               	movq	%rax, %r10
               	andq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rsi)
               	jne	<addr>
               	andq	%rdx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdi, <rip> # <addr>
               	movq	(%rsi), %rax
               	movq	%rax, %r10
               	orq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rsi)
               	jne	<addr>
               	orq	%rdx, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	xorq	%rdi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movl	$0x3, %esi
               	movq	%rsi, %r10
               	lock
               	xaddq	%r10, (%rdx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddq	%r10, (%rdx)
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fe, %r11     # imm = 0xFFFFFFFED5FA0E02
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %r8      # imm = 0xFFFFFFFED5FA0E00
               	movq	%r8, <rip> # <addr>
               	movl	$0xe, %r9d
               	lock
               	andq	%r9, (%rdx)
               	lock
               	orq	%rdi, (%rdx)
               	lock
               	xorq	%rsi, (%rdx)
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%r8, <rip> # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgq	%r10, (%rdx)
               	leaq	<rip>, %rax # <addr>
               	movq	<rip>, %rdx # <addr>
               	cmpq	$0x5, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movl	$0x9, %eax
               	xchgq	%rax, (%rdx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x3, %esi
               	movq	%rsi, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	addq	$0x3, %rdi
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	%rsi, %rdx
               	negq	%rdx
               	lock
               	xaddq	%rdx, (%rax)
               	leaq	-0x3(%rdx), %rax
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f203, %r11     # imm = 0xFFFFFFFED5FA0DFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, <rip> # <addr>
               	movl	$0x6, %edx
               	movq	(%rsi), %rax
               	movq	%rax, %r10
               	andq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rsi)
               	jne	<addr>
               	andq	%rdx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdi, <rip> # <addr>
               	movq	(%rsi), %rax
               	movq	%rax, %r10
               	orq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rsi)
               	jne	<addr>
               	orq	%rdx, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x6, %edi
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	xorq	%rdi, %rax
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movl	$0x3, %esi
               	movq	%rsi, %r10
               	lock
               	xaddq	%r10, (%rdx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddq	%r10, (%rdx)
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fe, %r11     # imm = 0xFFFFFFFED5FA0E02
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %r8      # imm = 0xFFFFFFFED5FA0E00
               	movq	%r8, <rip> # <addr>
               	movl	$0xe, %r9d
               	lock
               	andq	%r9, (%rdx)
               	lock
               	orq	%rdi, (%rdx)
               	lock
               	xorq	%rsi, (%rdx)
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%r8, <rip> # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgq	%r10, (%rdx)
               	leaq	<rip>, %rdi # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movl	$0x9, %esi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdi)
               	cmpq	%rdx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rdx, %rax
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	<rip>, %rdi # <addr>
               	cmpq	$0x9, %rdi
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	leaq	<rip>, %rdi # <addr>
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rdx, %rax
               	testl	%esi, %esi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x9, %r8d
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%r8, (%rdi)
               	cmpq	%rdx, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	movq	%rsi, <rip> # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movl	$0x9, %esi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdi)
               	cmpq	%rdx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movq	%rdx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x9, %r8d
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%r8, (%rdi)
               	cmpq	%rsi, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rsi, %rax
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	<rip>, %rdi # <addr>
               	cmpq	$0x9, %rdi
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rsi, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x9, %r8d
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%r8, (%rdi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rsi     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%r8, (%rdi)
               	cmpq	%rsi, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, %rax
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, <rip> # <addr>
               	movl	$0x9, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rsi     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rsi, <rip> # <addr>
               	leaq	<rip>, %r8 # <addr>
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%rdi, (%r8)
               	cmpq	%rsi, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x9, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testq	%r8, %r8
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %r8      # imm = 0xFFFFFFFED5FA0E00
               	movq	%r8, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rdx, %rax
               	testl	%esi, %esi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movq	%r8, <rip> # <addr>
               	movl	$0x9, %esi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdi)
               	cmpq	%rdx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rdx, <rip> # <addr>
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x9, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rdx, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0x9, %rsi
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movq	%rdx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	movl	$0x9, %esi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rdx, %rax
               	testl	%esi, %esi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x9, %r8d
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%r8, (%rdi)
               	cmpq	%rdx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movq	%rsi, <rip> # <addr>
               	movq	%rsi, <rip> # <addr>
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%r8, (%rdx)
               	cmpq	%rsi, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rsi     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rsi, <rip> # <addr>
               	movl	$0x9, %r8d
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%r8, (%rdi)
               	cmpq	%rsi, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movl	$0x9, %esi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdi)
               	cmpq	%rdx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %r8 # <addr>
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rsi, (%r8)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdi, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x9, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movq	%rdx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rdx, <rip> # <addr>
               	movl	$0x9, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rdx, %rax
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	<rip>, %rsi # <addr>
               	cmpq	$0x9, %rsi
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movq	%rdx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	movl	$0x9, %esi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	%rdx, %rax
               	testl	%esi, %esi
               	jne	<addr>
               	movq	<rip>, %rsi # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rsi
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rsi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, <rip> # <addr>
               	movl	$0x9, %r8d
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%r8, (%rdi)
               	cmpq	%rdx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movq	%rsi, <rip> # <addr>
               	movq	%rsi, <rip> # <addr>
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%r8, (%rdx)
               	cmpq	%rsi, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rsi     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rsi, <rip> # <addr>
               	movl	$0x9, %r8d
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%r8, (%rdi)
               	cmpq	%rsi, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movl	$0x9, %esi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdi)
               	cmpq	%rdx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %r8 # <addr>
               	movabsq	$-0x12a05f200, %rdi     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdi, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rsi, (%r8)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testl	%esi, %esi
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rdi, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	leaq	<rip>, %rsi # <addr>
               	movl	$0x9, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, %rax
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%sil
               	movzbq	%sil, %rsi
               	testq	%rsi, %rsi
               	je	<addr>
               	testq	%rsi, %rsi
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rsi # <addr>
               	movq	%rdx, <rip> # <addr>
               	movabsq	$-0x12a05f1ff, %rdx     # imm = 0xFFFFFFFED5FA0E01
               	movq	%rdx, <rip> # <addr>
               	movl	$0x9, %edi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testl	%edi, %edi
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, (%rsi)
               	movq	(%rsi), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movq	%rdx, (%rax)
               	movq	(%rax), %rdx
               	movabsq	$-0x12a05f1ff, %r11     # imm = 0xFFFFFFFED5FA0E01
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	(%rax), %rdx
               	movabsq	$-0x12a05f1ff, %r11     # imm = 0xFFFFFFFED5FA0E01
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movq	%rcx, %r10
               	xchgq	%r10, (%rax)
               	movq	(%rax), %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddq	%rdx, (%rcx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f1fd, %r11     # imm = 0xFFFFFFFED5FA0E03
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	negq	%rax
               	lock
               	xaddq	%rax, (%rcx)
               	subq	$0x3, %rax
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movl	$0x6, %edx
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f1fa, %r11     # imm = 0xFFFFFFFED5FA0E06
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x12a05f200, %rcx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rcx, <rip> # <addr>
               	movl	$0x9, %esi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movl	$0x8, %edi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdi, (%rdx)
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%rdx, (%rcx)
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movl	$0x9, %eax
               	lock
               	cmpxchgq	%rdi, (%rcx)
               	cmpq	$0x9, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	movl	$0x7, %eax
               	xchgq	%rax, (%rcx)
               	movabsq	$-0x12a05f200, %r11     # imm = 0xFFFFFFFED5FA0E00
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movq	%rax, (%rcx)
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x8f, %eax
               	retq
               	retq
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, %rsi
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, (%rcx)
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>

<schar_ops>:
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rax # <addr>
               	movb	$-0x3, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rdi
               	lock
               	xaddb	%dil, (%rax)
               	movsbq	%dil, %rdi
               	cmpl	$-0x3, %edi
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddb	%cl, (%rax)
               	movsbq	%cl, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x6, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movb	$-0x3, <rip> # <addr>
               	movl	$0x6, %edi
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, <rip> # <addr>
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movb	$-0x3, <rip> # <addr>
               	movl	$0x6, %edi
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x5, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, <rip> # <addr>
               	movl	$0x9, %eax
               	xchgb	%al, (%rcx)
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movb	$-0x3, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rdi
               	lock
               	xaddb	%dil, (%rax)
               	movsbq	%dil, %rdi
               	addq	$0x3, %rdi
               	movsbq	%dil, %rdi
               	testl	%edi, %edi
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddb	%cl, (%rax)
               	movsbq	%cl, %rax
               	subq	$0x3, %rax
               	movsbq	%al, %rax
               	cmpl	$-0x6, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x6, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movb	$-0x3, <rip> # <addr>
               	movl	$0x6, %ecx
               	movzbq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	lock
               	cmpxchgb	%r10b, (%rdx)
               	jne	<addr>
               	movsbq	%al, %rax
               	andq	%rcx, %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, <rip> # <addr>
               	movzbq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgb	%r10b, (%rdx)
               	jne	<addr>
               	movsbq	%al, %rax
               	orq	%rcx, %rax
               	movsbq	%al, %rax
               	cmpl	$-0x1, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movb	$-0x3, <rip> # <addr>
               	movl	$0x6, %edi
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	movsbq	%al, %rax
               	xorq	%rdi, %rax
               	movsbq	%al, %rax
               	cmpl	$-0x5, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x5, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %r10
               	lock
               	xaddb	%r10b, (%rcx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddb	%r10b, (%rcx)
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x1, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movb	$-0x3, <rip> # <addr>
               	movl	$0xe, %r9d
               	lock
               	andb	%r9b, (%rcx)
               	lock
               	orb	%dil, (%rcx)
               	lock
               	xorb	%dl, (%rcx)
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0xe, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, <rip> # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgb	%r10b, (%rcx)
               	leaq	<rip>, %rdi # <addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movq	$-0x3, %rcx
               	movb	%cl, <rip> # <addr>
               	movl	$0x9, %edx
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dl, (%rdi)
               	cmpl	$0xfd, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rcx, %rax
               	testq	%rdi, %rdi
               	je	<addr>
               	movsbq	<rip>, %rdi # <addr>
               	cmpl	$0x9, %edi
               	jne	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	%cl, <rip> # <addr>
               	movq	$-0x2, %rcx
               	leaq	<rip>, %rdi # <addr>
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dl, (%rdi)
               	cmpl	$0xfe, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rcx, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movsbq	<rip>, %rdx # <addr>
               	cmpl	$-0x3, %edx
               	jne	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x9, %r8d
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%r8b, (%rdi)
               	cmpl	$0xfe, %eax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	%cl, %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	$-0x3, <rip> # <addr>
               	movb	$-0x3, <rip> # <addr>
               	movq	$-0x3, %rcx
               	movl	$0x9, %edx
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dl, (%rdi)
               	cmpl	$0xfd, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movb	%cl, <rip> # <addr>
               	movq	$-0x2, %rcx
               	movb	%cl, <rip> # <addr>
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dl, (%rdi)
               	cmpl	$0xfe, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movq	$-0x3, %rdx
               	movb	%dl, (%rdi)
               	leaq	<rip>, %rax # <addr>
               	movzbq	(%rax), %rsi
               	movsbq	%sil, %rsi
               	cmpl	$-0x3, %esi
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movb	%cl, (%rax)
               	movzbq	(%rax), %rcx
               	movsbq	%cl, %rcx
               	cmpl	$-0x2, %ecx
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movzbq	(%rax), %rcx
               	movsbq	%cl, %rcx
               	cmpl	$-0x2, %ecx
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movq	%rdx, %r10
               	xchgb	%r10b, (%rax)
               	leaq	<rip>, %rcx # <addr>
               	movzbq	(%rcx), %rax
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddb	%dl, (%rcx)
               	movsbq	%dl, %rdx
               	cmpl	$-0x3, %edx
               	jne	<addr>
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	negq	%rax
               	lock
               	xaddb	%al, (%rcx)
               	movsbq	%al, %rax
               	subq	$0x3, %rax
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movl	$0x6, %edx
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x5, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movq	$-0x3, %rcx
               	movb	%cl, <rip> # <addr>
               	movl	$0x9, %esi
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%sil, (%rdx)
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movl	$0x8, %edi
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dil, (%rdx)
               	movsbq	%al, %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movq	$-0x3, %rdx
               	movzbq	%sil, %rax
               	lock
               	cmpxchgb	%dl, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movl	$0x9, %eax
               	movzbq	%al, %rax
               	lock
               	cmpxchgb	%dil, (%rcx)
               	cmpl	$0x9, %eax
               	je	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$-0x3, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	movl	$0x7, %eax
               	xchgb	%al, (%rcx)
               	movsbq	%al, %rax
               	cmpl	$-0x3, %eax
               	jne	<addr>
               	movsbq	<rip>, %rax # <addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movb	%al, (%rcx)
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x90, %eax
               	retq
               	retq
               	movb	%al, (%rsi)
               	jmp	<addr>
               	movb	%al, (%rsi)
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<uchar_ops>:
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rax # <addr>
               	movb	$-0x6, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rdi
               	lock
               	xaddb	%dil, (%rax)
               	andq	$0xff, %rdi
               	cmpl	$0xfa, %edi
               	jne	<addr>
               	movzbq	<rip>, %rdi # <addr>
               	cmpl	$0xfd, %edi
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddb	%cl, (%rax)
               	andq	$0xff, %rcx
               	cmpl	$0xfa, %ecx
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xf7, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movb	$-0x6, <rip> # <addr>
               	movl	$0x6, %edi
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, <rip> # <addr>
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfe, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movb	$-0x6, <rip> # <addr>
               	movl	$0x6, %edi
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfc, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, <rip> # <addr>
               	movl	$0x9, %eax
               	xchgb	%al, (%rcx)
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movb	$-0x6, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rdi
               	lock
               	xaddb	%dil, (%rax)
               	andq	$0xff, %rdi
               	addq	$0x3, %rdi
               	andq	$0xff, %rdi
               	cmpl	$0xfd, %edi
               	jne	<addr>
               	movzbq	<rip>, %rdi # <addr>
               	cmpl	$0xfd, %edi
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddb	%cl, (%rax)
               	andq	$0xff, %rcx
               	leaq	-0x3(%rcx), %rax
               	andq	$0xff, %rax
               	cmpl	$0xf7, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xf7, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movb	$-0x6, <rip> # <addr>
               	movl	$0x6, %ecx
               	movzbq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	lock
               	cmpxchgb	%r10b, (%rdx)
               	jne	<addr>
               	andq	$0xff, %rax
               	andq	%rcx, %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, <rip> # <addr>
               	movzbq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgb	%r10b, (%rdx)
               	jne	<addr>
               	andq	$0xff, %rax
               	orq	%rcx, %rax
               	cmpl	$0xfe, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfe, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movb	$-0x6, <rip> # <addr>
               	movl	$0x6, %edi
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	andq	$0xff, %rax
               	xorq	%rdi, %rax
               	cmpl	$0xfc, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfc, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %r10
               	lock
               	xaddb	%r10b, (%rcx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddb	%r10b, (%rcx)
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfc, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movb	$-0x6, <rip> # <addr>
               	movl	$0xe, %r9d
               	lock
               	andb	%r9b, (%rcx)
               	lock
               	orb	%dil, (%rcx)
               	lock
               	xorb	%dl, (%rcx)
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x8, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, <rip> # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgb	%r10b, (%rcx)
               	leaq	<rip>, %rdi # <addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movl	$0xfa, %ecx
               	movb	%cl, <rip> # <addr>
               	movl	$0x9, %edx
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dl, (%rdi)
               	cmpl	$0xfa, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rcx, %rax
               	testq	%rdi, %rdi
               	je	<addr>
               	movzbq	<rip>, %rdi # <addr>
               	cmpl	$0x9, %edi
               	jne	<addr>
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	%cl, <rip> # <addr>
               	movl	$0xfb, %ecx
               	leaq	<rip>, %rdi # <addr>
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dl, (%rdi)
               	cmpl	$0xfb, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rcx, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	<rip>, %rdx # <addr>
               	cmpl	$0xfa, %edx
               	jne	<addr>
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x9, %r8d
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%r8b, (%rdi)
               	cmpl	$0xfb, %eax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	cmpl	$0xfa, %ecx
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	$-0x6, <rip> # <addr>
               	movb	$-0x6, <rip> # <addr>
               	movl	$0xfa, %ecx
               	movl	$0x9, %edx
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dl, (%rdi)
               	cmpl	$0xfa, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movb	%cl, <rip> # <addr>
               	movl	$0xfb, %ecx
               	movb	%cl, <rip> # <addr>
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dl, (%rdi)
               	cmpl	$0xfb, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movl	$0xfa, %edx
               	movb	%dl, (%rdi)
               	leaq	<rip>, %rax # <addr>
               	movzbq	(%rax), %rsi
               	cmpl	$0xfa, %esi
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movb	%cl, (%rax)
               	movzbq	(%rax), %rcx
               	cmpl	$0xfb, %ecx
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movzbq	(%rax), %rcx
               	cmpl	$0xfb, %ecx
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movq	%rdx, %r10
               	xchgb	%r10b, (%rax)
               	leaq	<rip>, %rcx # <addr>
               	movzbq	(%rcx), %rax
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddb	%dl, (%rcx)
               	andq	$0xff, %rdx
               	cmpl	$0xfa, %edx
               	jne	<addr>
               	movzbq	<rip>, %rdx # <addr>
               	cmpl	$0xfd, %edx
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	negq	%rax
               	lock
               	xaddb	%al, (%rcx)
               	andq	$0xff, %rax
               	subq	$0x3, %rax
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movl	$0x6, %edx
               	movzbq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgb	%r10b, (%rcx)
               	jne	<addr>
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfc, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movl	$0xfa, %ecx
               	movb	%cl, <rip> # <addr>
               	movl	$0x9, %esi
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%sil, (%rdx)
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movl	$0x8, %edi
               	movzbq	%cl, %rax
               	lock
               	cmpxchgb	%dil, (%rdx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xfa, %edx
               	movzbq	%sil, %rax
               	lock
               	cmpxchgb	%dl, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movl	$0x9, %eax
               	movzbq	%al, %rax
               	lock
               	cmpxchgb	%dil, (%rcx)
               	cmpl	$0x9, %eax
               	je	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0xfa, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	movl	$0x7, %eax
               	xchgb	%al, (%rcx)
               	andq	$0xff, %rax
               	cmpl	$0xfa, %eax
               	jne	<addr>
               	movzbq	<rip>, %rax # <addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movb	%al, (%rcx)
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x91, %eax
               	retq
               	retq
               	movb	%al, (%rsi)
               	jmp	<addr>
               	movb	%al, (%rsi)
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<short_ops>:
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rax # <addr>
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rdi
               	lock
               	xaddw	%di, (%rax)
               	movswq	%di, %rdi
               	cmpl	$0xfffffed4, %edi       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rdi # <addr>
               	cmpl	$0xfffffed7, %edi       # imm = 0xFFFFFED7
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddw	%cx, (%rax)
               	movswq	%cx, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed1, %eax       # imm = 0xFFFFFED1
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movl	$0x6, %edi
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed6, %eax       # imm = 0xFFFFFED6
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movl	$0x6, %edi
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed2, %eax       # imm = 0xFFFFFED2
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movl	$0x9, %eax
               	xchgw	%ax, (%rcx)
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rdi
               	lock
               	xaddw	%di, (%rax)
               	movswq	%di, %rdi
               	addq	$0x3, %rdi
               	movswq	%di, %rdi
               	cmpl	$0xfffffed7, %edi       # imm = 0xFFFFFED7
               	jne	<addr>
               	movswq	<rip>, %rdi # <addr>
               	cmpl	$0xfffffed7, %edi       # imm = 0xFFFFFED7
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddw	%cx, (%rax)
               	movswq	%cx, %rax
               	subq	$0x3, %rax
               	movswq	%ax, %rax
               	cmpl	$0xfffffed1, %eax       # imm = 0xFFFFFED1
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed1, %eax       # imm = 0xFFFFFED1
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movl	$0x6, %ecx
               	movzwq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	lock
               	cmpxchgw	%r10w, (%rdx)
               	jne	<addr>
               	movswq	%ax, %rax
               	andq	%rcx, %rax
               	cmpl	$0x4, %eax
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movzwq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgw	%r10w, (%rdx)
               	jne	<addr>
               	movswq	%ax, %rax
               	orq	%rcx, %rax
               	movswq	%ax, %rax
               	cmpl	$0xfffffed6, %eax       # imm = 0xFFFFFED6
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed6, %eax       # imm = 0xFFFFFED6
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movl	$0x6, %edi
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	movswq	%ax, %rax
               	xorq	%rdi, %rax
               	movswq	%ax, %rax
               	cmpl	$0xfffffed2, %eax       # imm = 0xFFFFFED2
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed2, %eax       # imm = 0xFFFFFED2
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %r10
               	lock
               	xaddw	%r10w, (%rcx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddw	%r10w, (%rcx)
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed6, %eax       # imm = 0xFFFFFED6
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movl	$0xe, %r9d
               	lock
               	andw	%r9w, (%rcx)
               	lock
               	orw	%di, (%rcx)
               	lock
               	xorw	%dx, (%rcx)
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0x6, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgw	%r10w, (%rcx)
               	leaq	<rip>, %rdi # <addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movq	$-0x12c, %rcx           # imm = 0xFED4
               	movw	%cx, <rip> # <addr>
               	movl	$0x9, %edx
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%dx, (%rdi)
               	cmpl	$0xfed4, %eax           # imm = 0xFED4
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rcx, %rax
               	testq	%rdi, %rdi
               	je	<addr>
               	movswq	<rip>, %rdi # <addr>
               	cmpl	$0x9, %edi
               	jne	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	%cx, <rip> # <addr>
               	movq	$-0x12b, %rcx           # imm = 0xFED5
               	leaq	<rip>, %rdi # <addr>
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%dx, (%rdi)
               	cmpl	$0xfed5, %eax           # imm = 0xFED5
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rcx, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movswq	<rip>, %rdx # <addr>
               	cmpl	$0xfffffed4, %edx       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x9, %r8d
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%r8w, (%rdi)
               	cmpl	$0xfed5, %eax           # imm = 0xFED5
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	%cx, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movw	$0xfed4, <rip> # imm = 0xFED4
                                                # <addr>
               	movq	$-0x12c, %rcx           # imm = 0xFED4
               	movl	$0x9, %edx
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%dx, (%rdi)
               	cmpl	$0xfed4, %eax           # imm = 0xFED4
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movw	%cx, <rip> # <addr>
               	movq	$-0x12b, %rcx           # imm = 0xFED5
               	movw	%cx, <rip> # <addr>
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%dx, (%rdi)
               	cmpl	$0xfed5, %eax           # imm = 0xFED5
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movq	$-0x12c, %rdx           # imm = 0xFED4
               	movw	%dx, (%rdi)
               	leaq	<rip>, %rax # <addr>
               	movzwq	(%rax), %rsi
               	movswq	%si, %rsi
               	cmpl	$0xfffffed4, %esi       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movw	%cx, (%rax)
               	movzwq	(%rax), %rcx
               	movswq	%cx, %rcx
               	cmpl	$0xfffffed5, %ecx       # imm = 0xFFFFFED5
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movzwq	(%rax), %rcx
               	movswq	%cx, %rcx
               	cmpl	$0xfffffed5, %ecx       # imm = 0xFFFFFED5
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movq	%rdx, %r10
               	xchgw	%r10w, (%rax)
               	leaq	<rip>, %rcx # <addr>
               	movzwq	(%rcx), %rax
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddw	%dx, (%rcx)
               	movswq	%dx, %rdx
               	cmpl	$0xfffffed4, %edx       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rdx # <addr>
               	cmpl	$0xfffffed7, %edx       # imm = 0xFFFFFED7
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	negq	%rax
               	lock
               	xaddw	%ax, (%rcx)
               	movswq	%ax, %rax
               	subq	$0x3, %rax
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movl	$0x6, %edx
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed2, %eax       # imm = 0xFFFFFED2
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movq	$-0x12c, %rcx           # imm = 0xFED4
               	movw	%cx, <rip> # <addr>
               	movl	$0x9, %esi
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%si, (%rdx)
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movl	$0x8, %edi
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%di, (%rdx)
               	movswq	%ax, %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movq	$-0x12c, %rdx           # imm = 0xFED4
               	movzwl	%si, %eax
               	lock
               	cmpxchgw	%dx, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movl	$0x9, %eax
               	movzwl	%ax, %eax
               	lock
               	cmpxchgw	%di, (%rcx)
               	cmpl	$0x9, %eax
               	je	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	movl	$0x7, %eax
               	xchgw	%ax, (%rcx)
               	movswq	%ax, %rax
               	cmpl	$0xfffffed4, %eax       # imm = 0xFFFFFED4
               	jne	<addr>
               	movswq	<rip>, %rax # <addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movw	%ax, (%rcx)
               	cmpw	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x92, %eax
               	retq
               	retq
               	movw	%ax, (%rsi)
               	jmp	<addr>
               	movw	%ax, (%rsi)
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<ushort_ops>:
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rax # <addr>
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rdi
               	lock
               	xaddw	%di, (%rax)
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	cmpl	$0xfde8, %edi           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rdi # <addr>
               	cmpl	$0xfdeb, %edi           # imm = 0xFDEB
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddw	%cx, (%rax)
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	cmpl	$0xfde8, %ecx           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfde5, %eax           # imm = 0xFDE5
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movl	$0x6, %edi
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	cmpw	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfdee, %eax           # imm = 0xFDEE
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movl	$0x6, %edi
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfdee, %eax           # imm = 0xFDEE
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movl	$0x9, %eax
               	xchgw	%ax, (%rcx)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rdi
               	lock
               	xaddw	%di, (%rax)
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	addq	$0x3, %rdi
               	andq	$0xffff, %rdi           # imm = 0xFFFF
               	cmpl	$0xfdeb, %edi           # imm = 0xFDEB
               	jne	<addr>
               	movzwq	<rip>, %rdi # <addr>
               	cmpl	$0xfdeb, %edi           # imm = 0xFDEB
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddw	%cx, (%rax)
               	andq	$0xffff, %rcx           # imm = 0xFFFF
               	leaq	-0x3(%rcx), %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde5, %eax           # imm = 0xFDE5
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfde5, %eax           # imm = 0xFDE5
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movl	$0x6, %ecx
               	movzwq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	lock
               	cmpxchgw	%r10w, (%rdx)
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	andq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpw	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movzwq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgw	%r10w, (%rdx)
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	orq	%rcx, %rax
               	cmpl	$0xfdee, %eax           # imm = 0xFDEE
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfdee, %eax           # imm = 0xFDEE
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movl	$0x6, %edi
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	xorq	%rdi, %rax
               	cmpl	$0xfdee, %eax           # imm = 0xFDEE
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfdee, %eax           # imm = 0xFDEE
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %r10
               	lock
               	xaddw	%r10w, (%rcx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddw	%r10w, (%rcx)
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfdea, %eax           # imm = 0xFDEA
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movl	$0xe, %r9d
               	lock
               	andw	%r9w, (%rcx)
               	lock
               	orw	%di, (%rcx)
               	lock
               	xorw	%dx, (%rcx)
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgw	%r10w, (%rcx)
               	leaq	<rip>, %rdi # <addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movl	$0xfde8, %ecx           # imm = 0xFDE8
               	movw	%cx, <rip> # <addr>
               	movl	$0x9, %edx
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%dx, (%rdi)
               	cmpl	%ecx, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rcx, %rax
               	testq	%rdi, %rdi
               	je	<addr>
               	movzwq	<rip>, %rdi # <addr>
               	cmpl	$0x9, %edi
               	jne	<addr>
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	%cx, <rip> # <addr>
               	movl	$0xfde9, %ecx           # imm = 0xFDE9
               	leaq	<rip>, %rdi # <addr>
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%dx, (%rdi)
               	cmpl	%ecx, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rcx, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movzwq	<rip>, %rdx # <addr>
               	cmpl	$0xfde8, %edx           # imm = 0xFDE8
               	jne	<addr>
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x9, %r8d
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%r8w, (%rdi)
               	cmpl	%ecx, %eax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	cmpl	$0xfde8, %ecx           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movw	$0xfde8, <rip> # imm = 0xFDE8
                                                # <addr>
               	movl	$0xfde8, %ecx           # imm = 0xFDE8
               	movl	$0x9, %edx
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%dx, (%rdi)
               	cmpl	%ecx, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movw	%cx, <rip> # <addr>
               	movl	$0xfde9, %ecx           # imm = 0xFDE9
               	movw	%cx, <rip> # <addr>
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%dx, (%rdi)
               	cmpl	%ecx, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movl	$0xfde8, %edx           # imm = 0xFDE8
               	movw	%dx, (%rdi)
               	leaq	<rip>, %rax # <addr>
               	movzwq	(%rax), %rsi
               	cmpl	$0xfde8, %esi           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movw	%cx, (%rax)
               	movzwq	(%rax), %rcx
               	cmpl	$0xfde9, %ecx           # imm = 0xFDE9
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movzwq	(%rax), %rcx
               	cmpl	$0xfde9, %ecx           # imm = 0xFDE9
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movq	%rdx, %r10
               	xchgw	%r10w, (%rax)
               	leaq	<rip>, %rcx # <addr>
               	movzwq	(%rcx), %rax
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddw	%dx, (%rcx)
               	andq	$0xffff, %rdx           # imm = 0xFFFF
               	cmpl	$0xfde8, %edx           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rdx # <addr>
               	cmpl	$0xfdeb, %edx           # imm = 0xFDEB
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	negq	%rax
               	lock
               	xaddw	%ax, (%rcx)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	subq	$0x3, %rax
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movl	$0x6, %edx
               	movzwq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgw	%r10w, (%rcx)
               	jne	<addr>
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfdee, %eax           # imm = 0xFDEE
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movl	$0xfde8, %ecx           # imm = 0xFDE8
               	movw	%cx, <rip> # <addr>
               	movl	$0x9, %esi
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%si, (%rdx)
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movl	$0x8, %edi
               	movzwl	%cx, %eax
               	lock
               	cmpxchgw	%di, (%rdx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xfde8, %edx           # imm = 0xFDE8
               	movzwl	%si, %eax
               	lock
               	cmpxchgw	%dx, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movl	$0x9, %eax
               	movzwl	%ax, %eax
               	lock
               	cmpxchgw	%di, (%rcx)
               	cmpl	$0x9, %eax
               	je	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	movl	$0x7, %eax
               	xchgw	%ax, (%rcx)
               	andq	$0xffff, %rax           # imm = 0xFFFF
               	cmpl	$0xfde8, %eax           # imm = 0xFDE8
               	jne	<addr>
               	movzwq	<rip>, %rax # <addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movw	%ax, (%rcx)
               	cmpw	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x93, %eax
               	retq
               	retq
               	movw	%ax, (%rsi)
               	jmp	<addr>
               	movw	%ax, (%rsi)
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<uint_ops>:
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rax # <addr>
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rdi
               	lock
               	xaddl	%edi, (%rax)
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %edi
               	jne	<addr>
               	movl	<rip>, %edi # <addr>
               	movl	$0xee6b2803, %r11d      # imm = 0xEE6B2803
               	cmpl	%r11d, %edi
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddl	%ecx, (%rax)
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	movq	%rcx, %rax
               	cmpl	%r11d, %ecx
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	$0xee6b27fd, %r11d      # imm = 0xEE6B27FD
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0x6, %edi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	$0xee6b2806, %r11d      # imm = 0xEE6B2806
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0x6, %edi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	$0xee6b2806, %r11d      # imm = 0xEE6B2806
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0x9, %eax
               	xchgl	%eax, (%rcx)
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rdi
               	lock
               	xaddl	%edi, (%rax)
               	addq	$0x3, %rdi
               	movl	$0xee6b2803, %r11d      # imm = 0xEE6B2803
               	cmpl	%r11d, %edi
               	jne	<addr>
               	movl	<rip>, %edi # <addr>
               	movl	$0xee6b2803, %r11d      # imm = 0xEE6B2803
               	cmpl	%r11d, %edi
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddl	%ecx, (%rax)
               	leaq	-0x3(%rcx), %rax
               	movl	$0xee6b27fd, %r11d      # imm = 0xEE6B27FD
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	$0xee6b27fd, %r11d      # imm = 0xEE6B27FD
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0x6, %ecx
               	movl	(%rdx), %eax
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	lock
               	cmpxchgl	%r10d, (%rdx)
               	jne	<addr>
               	andq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	(%rdx), %eax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgl	%r10d, (%rdx)
               	jne	<addr>
               	orq	%rcx, %rax
               	movl	$0xee6b2806, %r11d      # imm = 0xEE6B2806
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	$0xee6b2806, %r11d      # imm = 0xEE6B2806
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0x6, %edi
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	xorq	%rdi, %rax
               	movl	$0xee6b2806, %r11d      # imm = 0xEE6B2806
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	$0xee6b2806, %r11d      # imm = 0xEE6B2806
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %r10
               	lock
               	xaddl	%r10d, (%rcx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddl	%r10d, (%rcx)
               	movl	<rip>, %eax # <addr>
               	movl	$0xee6b2802, %r11d      # imm = 0xEE6B2802
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0xe, %r9d
               	lock
               	andl	%r9d, (%rcx)
               	lock
               	orl	%edi, (%rcx)
               	lock
               	xorl	%edx, (%rcx)
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x2, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgl	%r10d, (%rcx)
               	leaq	<rip>, %rdi # <addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x5, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, %ecx       # imm = 0xEE6B2800
               	movl	%ecx, <rip> # <addr>
               	movl	$0x9, %edx
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edx, (%rdi)
               	cmpl	%ecx, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rcx, %rax
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	<rip>, %edi # <addr>
               	cmpl	$0x9, %edi
               	jne	<addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	%ecx, <rip> # <addr>
               	movl	$0xee6b2801, %ecx       # imm = 0xEE6B2801
               	leaq	<rip>, %rdi # <addr>
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edx, (%rdi)
               	cmpl	%ecx, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rcx, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movl	<rip>, %edx # <addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %edx
               	jne	<addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x9, %r8d
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%r8d, (%rdi)
               	cmpl	%ecx, %eax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	movq	%rcx, %rax
               	cmpl	%r11d, %ecx
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0xee6b2800, <rip> # imm = 0xEE6B2800
                                                # <addr>
               	movl	$0xee6b2800, %ecx       # imm = 0xEE6B2800
               	movl	$0x9, %edx
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edx, (%rdi)
               	cmpl	%ecx, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movl	%ecx, <rip> # <addr>
               	movl	$0xee6b2801, %ecx       # imm = 0xEE6B2801
               	movl	%ecx, <rip> # <addr>
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edx, (%rdi)
               	cmpl	%ecx, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0xee6b2800, %edx       # imm = 0xEE6B2800
               	movl	%edx, (%rdi)
               	leaq	<rip>, %rax # <addr>
               	movl	(%rax), %esi
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %esi
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	%ecx, (%rax)
               	movl	(%rax), %ecx
               	movl	$0xee6b2801, %r11d      # imm = 0xEE6B2801
               	cmpl	%r11d, %ecx
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	(%rax), %ecx
               	movl	$0xee6b2801, %r11d      # imm = 0xEE6B2801
               	cmpl	%r11d, %ecx
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movq	%rdx, %r10
               	xchgl	%r10d, (%rax)
               	leaq	<rip>, %rcx # <addr>
               	movl	(%rcx), %eax
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddl	%edx, (%rcx)
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %edx
               	jne	<addr>
               	movl	<rip>, %edx # <addr>
               	movl	$0xee6b2803, %r11d      # imm = 0xEE6B2803
               	cmpl	%r11d, %edx
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	negq	%rax
               	lock
               	xaddl	%eax, (%rcx)
               	subq	$0x3, %rax
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0x6, %edx
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	$0xee6b2806, %r11d      # imm = 0xEE6B2806
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movl	$0xee6b2800, %ecx       # imm = 0xEE6B2800
               	movl	%ecx, <rip> # <addr>
               	movl	$0x9, %esi
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%esi, (%rdx)
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0x8, %edi
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edi, (%rdx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xee6b2800, %edx       # imm = 0xEE6B2800
               	movl	%esi, %eax
               	lock
               	cmpxchgl	%edx, (%rcx)
               	cmpl	$0x9, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0x9, %eax
               	movl	%eax, %eax
               	lock
               	cmpxchgl	%edi, (%rcx)
               	cmpl	$0x9, %eax
               	je	<addr>
               	movl	<rip>, %eax # <addr>
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	movl	$0x7, %eax
               	xchgl	%eax, (%rcx)
               	movl	$0xee6b2800, %r11d      # imm = 0xEE6B2800
               	cmpl	%r11d, %eax
               	jne	<addr>
               	movl	<rip>, %eax # <addr>
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movl	%eax, (%rcx)
               	cmpl	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x94, %eax
               	retq
               	retq
               	movl	%eax, (%rsi)
               	jmp	<addr>
               	movl	%eax, (%rsi)
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<ullong_ops>:
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rax # <addr>
               	movabsq	$-0x7000000000000000, %rcx # imm = 0x9000000000000000
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	movabsq	$-0x6ffffffffffffffd, %r11 # imm = 0x9000000000000003
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddq	%rcx, (%rax)
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x7000000000000003, %r11 # imm = 0x8FFFFFFFFFFFFFFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x7000000000000000, %rdx # imm = 0x9000000000000000
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %edi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	andq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	orq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x6ffffffffffffffa, %r11 # imm = 0x9000000000000006
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x7000000000000000, %rdx # imm = 0x9000000000000000
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %edi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x6ffffffffffffffa, %r11 # imm = 0x9000000000000006
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movl	$0x9, %eax
               	xchgq	%rax, (%rcx)
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rax # <addr>
               	movabsq	$-0x7000000000000000, %rcx # imm = 0x9000000000000000
               	movq	%rcx, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %rdi
               	lock
               	xaddq	%rdi, (%rax)
               	addq	$0x3, %rdi
               	movabsq	$-0x6ffffffffffffffd, %r11 # imm = 0x9000000000000003
               	cmpq	%r11, %rdi
               	jne	<addr>
               	movq	<rip>, %rdi # <addr>
               	movabsq	$-0x6ffffffffffffffd, %r11 # imm = 0x9000000000000003
               	cmpq	%r11, %rdi
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movq	%rdx, %rcx
               	negq	%rcx
               	lock
               	xaddq	%rcx, (%rax)
               	leaq	-0x3(%rcx), %rax
               	movabsq	$-0x7000000000000003, %r11 # imm = 0x8FFFFFFFFFFFFFFD
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x7000000000000003, %r11 # imm = 0x8FFFFFFFFFFFFFFD
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x7000000000000000, %rdi # imm = 0x9000000000000000
               	movq	%rdi, <rip> # <addr>
               	movl	$0x6, %ecx
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	andq	%rcx, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	andq	%rcx, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rdi, <rip> # <addr>
               	movq	(%rdx), %rax
               	movq	%rax, %r10
               	orq	%rcx, %r10
               	lock
               	cmpxchgq	%r10, (%rdx)
               	jne	<addr>
               	orq	%rcx, %rax
               	movabsq	$-0x6ffffffffffffffa, %r11 # imm = 0x9000000000000006
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x6ffffffffffffffa, %r11 # imm = 0x9000000000000006
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x7000000000000000, %rdx # imm = 0x9000000000000000
               	movq	%rdx, <rip> # <addr>
               	movl	$0x6, %edi
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdi, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	xorq	%rdi, %rax
               	movabsq	$-0x6ffffffffffffffa, %r11 # imm = 0x9000000000000006
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x6ffffffffffffffa, %r11 # imm = 0x9000000000000006
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movl	$0x3, %edx
               	movq	%rdx, %r10
               	lock
               	xaddq	%r10, (%rcx)
               	movl	$0x1, %edi
               	movq	%rdi, %r10
               	negq	%r10
               	lock
               	xaddq	%r10, (%rcx)
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x6ffffffffffffffe, %r11 # imm = 0x9000000000000002
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x7000000000000000, %r8 # imm = 0x9000000000000000
               	movq	%r8, <rip> # <addr>
               	movl	$0xe, %r9d
               	lock
               	andq	%r9, (%rcx)
               	lock
               	orq	%rdi, (%rcx)
               	lock
               	xorq	%rdx, (%rcx)
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%r8, <rip> # <addr>
               	movl	$0x5, %eax
               	movq	%rax, %r10
               	xchgq	%r10, (%rcx)
               	leaq	<rip>, %rdi # <addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x5, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movabsq	$-0x7000000000000000, %rcx # imm = 0x9000000000000000
               	movq	%rcx, <rip> # <addr>
               	movl	$0x9, %edx
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rdi)
               	cmpq	%rcx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	%rcx, %rax
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	<rip>, %rdi # <addr>
               	cmpq	$0x9, %rdi
               	jne	<addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rcx, <rip> # <addr>
               	movabsq	$-0x6fffffffffffffff, %rcx # imm = 0x9000000000000001
               	leaq	<rip>, %rdi # <addr>
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rdi)
               	cmpq	%rcx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	movq	%rcx, %rax
               	testl	%edx, %edx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movabsq	$-0x7000000000000000, %rdx # imm = 0x9000000000000000
               	movq	%rdx, <rip> # <addr>
               	leaq	<rip>, %rdi # <addr>
               	movl	$0x9, %r8d
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%r8, (%rdi)
               	cmpq	%rcx, %rax
               	sete	%r8b
               	movzbq	%r8b, %r8
               	testq	%r8, %r8
               	je	<addr>
               	testl	%r8d, %r8d
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	movq	%rcx, %rax
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rdx, <rip> # <addr>
               	movq	%rdx, <rip> # <addr>
               	movabsq	$-0x7000000000000000, %rcx # imm = 0x9000000000000000
               	movl	$0x9, %edx
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rdi)
               	cmpq	%rcx, %rax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rdi # <addr>
               	movq	%rcx, <rip> # <addr>
               	movabsq	$-0x6fffffffffffffff, %rcx # imm = 0x9000000000000001
               	movq	%rcx, <rip> # <addr>
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdx, (%rdi)
               	cmpq	%rcx, %rax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movabsq	$-0x7000000000000000, %rdx # imm = 0x9000000000000000
               	movq	%rdx, (%rdi)
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax), %rsi
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rsi
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rcx, (%rax)
               	movq	(%rax), %rcx
               	movabsq	$-0x6fffffffffffffff, %r11 # imm = 0x9000000000000001
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	(%rax), %rcx
               	movabsq	$-0x6fffffffffffffff, %r11 # imm = 0x9000000000000001
               	cmpq	%r11, %rcx
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movq	%rdx, %r10
               	xchgq	%r10, (%rax)
               	leaq	<rip>, %rcx # <addr>
               	movq	(%rcx), %rax
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movl	$0x3, %eax
               	movq	%rax, %rdx
               	lock
               	xaddq	%rdx, (%rcx)
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rdx
               	jne	<addr>
               	movq	<rip>, %rdx # <addr>
               	movabsq	$-0x6ffffffffffffffd, %r11 # imm = 0x9000000000000003
               	cmpq	%r11, %rdx
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	negq	%rax
               	lock
               	xaddq	%rax, (%rcx)
               	subq	$0x3, %rax
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movl	$0x6, %edx
               	movq	(%rcx), %rax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgq	%r10, (%rcx)
               	jne	<addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x6ffffffffffffffa, %r11 # imm = 0x9000000000000006
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movabsq	$-0x7000000000000000, %rcx # imm = 0x9000000000000000
               	movq	%rcx, <rip> # <addr>
               	movl	$0x9, %esi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rsi, (%rdx)
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movl	$0x8, %edi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdi, (%rdx)
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x9, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x7000000000000000, %rdx # imm = 0x9000000000000000
               	movq	%rsi, %rax
               	lock
               	cmpxchgq	%rdx, (%rcx)
               	cmpq	$0x9, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movl	$0x9, %eax
               	lock
               	cmpxchgq	%rdi, (%rcx)
               	cmpq	$0x9, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	movl	$0x7, %eax
               	xchgq	%rax, (%rcx)
               	movabsq	$-0x7000000000000000, %r11 # imm = 0x9000000000000000
               	cmpq	%r11, %rax
               	jne	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	xorl	%eax, %eax
               	movq	%rax, (%rcx)
               	cmpq	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0x95, %eax
               	retq
               	retq
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	movq	%rax, (%rsi)
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>

<other_ops>:
               	leaq	<rip>, %rsi # <addr>
               	leaq	<rip>, %rcx # <addr>
               	movq	%rcx, <rip> # <addr>
               	leaq	0x4(%rcx), %rdi
               	movq	%rcx, %rax
               	lock
               	cmpxchgq	%rdi, (%rsi)
               	movq	%rax, %rdx
               	cmpq	%rcx, %rdx
               	sete	%al
               	movzbq	%al, %rax
               	testq	%rax, %rax
               	je	<addr>
               	movq	%rcx, %rdx
               	testq	%rax, %rax
               	je	<addr>
               	movq	<rip>, %rax # <addr>
               	cmpq	%rdi, %rax
               	je	<addr>
               	movl	$0xa6, %eax
               	retq
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rcx, (%rsi)
               	cmpq	%rdx, %rax
               	sete	%cl
               	movzbq	%cl, %rcx
               	testq	%rcx, %rcx
               	je	<addr>
               	testl	%ecx, %ecx
               	jne	<addr>
               	leaq	<rip>, %rax # <addr>
               	addq	$0x4, %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movl	$0xa7, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	leaq	<rip>, %rax # <addr>
               	movq	%rax, %rdx
               	xchgq	%rdx, (%rcx)
               	leaq	0x4(%rax), %rcx
               	cmpq	%rcx, %rdx
               	jne	<addr>
               	movq	<rip>, %rcx # <addr>
               	cmpq	%rax, %rcx
               	je	<addr>
               	movl	$0xa8, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0xa, %eax
               	movl	%eax, (%rcx)
               	movl	$0x5, %esi
               	movq	%rsi, %rax
               	lock
               	xaddl	%eax, (%rcx)
               	cmpl	$0xa, %eax
               	jne	<addr>
               	movl	(%rcx), %eax
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0xab, %eax
               	retq
               	movl	$0x3, %eax
               	negq	%rax
               	lock
               	xaddl	%eax, (%rcx)
               	cmpl	$0xf, %eax
               	je	<addr>
               	movl	$0xac, %eax
               	retq
               	movl	$0x40, %edx
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	orq	%rdx, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0xc, %eax
               	je	<addr>
               	movl	$0xad, %eax
               	retq
               	movl	$0x48, %edx
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	andq	%rdx, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0x4c, %eax
               	je	<addr>
               	movl	$0xae, %eax
               	retq
               	movl	$0x1, %edx
               	movl	(%rcx), %eax
               	movq	%rax, %r10
               	xorq	%rdx, %r10
               	lock
               	cmpxchgl	%r10d, (%rcx)
               	jne	<addr>
               	cmpl	$0x48, %eax
               	je	<addr>
               	movl	$0xaf, %eax
               	retq
               	leaq	<rip>, %rdx # <addr>
               	movq	$-0x1, %rcx
               	movq	%rcx, %rax
               	xchgl	%eax, (%rdx)
               	cmpl	$0x49, %eax
               	je	<addr>
               	movl	$0xb0, %eax
               	retq
               	movl	$0x4, %edi
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%edi, (%rdx)
               	movl	$0xffffffff, %r11d      # imm = 0xFFFFFFFF
               	movq	%rax, %rdi
               	cmpl	%r11d, %eax
               	sete	%dil
               	movzbq	%dil, %rdi
               	testq	%rdi, %rdi
               	je	<addr>
               	testq	%rdi, %rdi
               	je	<addr>
               	movl	(%rdx), %eax
               	cmpl	$0x4, %eax
               	je	<addr>
               	movl	$0xb2, %eax
               	retq
               	movl	%ecx, %eax
               	lock
               	cmpxchgl	%esi, (%rdx)
               	cmpl	%ecx, %eax
               	sete	%dl
               	movzbq	%dl, %rdx
               	testq	%rdx, %rdx
               	je	<addr>
               	testl	%edx, %edx
               	jne	<addr>
               	cmpl	$0x4, %ecx
               	je	<addr>
               	movl	$0xb3, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movabsq	$-0x12a05f200, %rdx     # imm = 0xFFFFFFFED5FA0E00
               	movq	%rdx, (%rcx)
               	movl	$0x7, %esi
               	movq	%rdx, %rax
               	lock
               	cmpxchgq	%rsi, (%rcx)
               	cmpq	%rdx, %rax
               	jne	<addr>
               	movq	(%rcx), %rax
               	cmpq	$0x7, %rax
               	je	<addr>
               	movl	$0xb8, %eax
               	retq
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x1, %edx
               	movq	%rdx, %rax
               	xchgb	%al, (%rcx)
               	movsbq	%al, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0xbc, %eax
               	retq
               	movq	%rdx, %rax
               	xchgb	%al, (%rcx)
               	movsbq	%al, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movl	$0xbd, %eax
               	retq
               	xorl	%eax, %eax
               	movb	%al, (%rcx)
               	xchgb	%dl, (%rcx)
               	movsbq	%dl, %rdx
               	testl	%edx, %edx
               	je	<addr>
               	movl	$0xbf, %eax
               	retq
               	movq	%rax, %r10
               	xchgb	%r10b, (%rcx)
               	leaq	<rip>, %rcx # <addr>
               	movl	$0x1, %edx
               	movq	%rdx, %rsi
               	xchgb	%sil, (%rcx)
               	testb	$-0x1, %sil
               	jne	<addr>
               	xchgb	%dl, (%rcx)
               	testb	$-0x1, %dl
               	jne	<addr>
               	movl	$0xc1, %eax
               	retq
               	movb	%al, (%rcx)
               	cmpb	$0x0, <rip> # <addr>
               	je	<addr>
               	movl	$0xc3, %eax
               	retq
               	retq
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rcx
               	jmp	<addr>
               	movq	%rax, %rdx
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	callq	<addr>
               	movslq	%eax, %rax
               	testq	%rax, %rax
               	je	<addr>
               	popq	%rbp
               	retq
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
